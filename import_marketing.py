import os
import re
import unicodedata
import pandas as pd
import easyocr
import fitz  # PyMuPDF
from sqlalchemy import create_engine, text

# ==========================================
# 1. 環境初始化 (GPU 啟動)
# ==========================================
print("🧠 正在初始化 EasyOCR (GPU 全力運作中)...")
reader = easyocr.Reader(['ch_tra', 'en'], gpu=True)

DB_URL = "postgresql://postgres:postgres@localhost:5432/bubble_tea"
engine = create_engine(DB_URL)

STORE_NAMES = ["功夫茶", "大茗本位制茶堂", "得正", "先喝道", "清新福全", "迷克夏", "Comebuy", "龜記", "五十嵐", "Coco都可"]
# 擴充了各種寫法的品牌名，確保絕對不會抓到店家名稱
BRAND_MAP = {
    "功夫茶": "功夫茶", "大茗": "大茗本位制茶堂", "得正": "得正", "先喝道": "先喝道",
    "清心福全": "清新福全", "清新福全": "清新福全", "迷客夏": "迷克夏", "迷克夏": "迷克夏",
    "comebuy": "Comebuy", "龜記": "龜記", "50嵐": "五十嵐", "coco都可": "Coco都可"
}

BRAND_EXCLUDE = ["功夫茶", "KUNGFUTEA", "大茗本位制茶堂", "大茗本位製茶堂", "本位製茶堂", "本位制茶堂", "大茗", "本位製茶", "DAMING", "得正", "先喝道", "清新福全", "清心福全", "迷客夏", "迷克夏", "MILKSHA", "COMEBUY", "龜記", "GUIJI", "五十嵐", "50嵐", "COCO", "都可"]

# 🧬 【黃金字尾鎖】飲料名稱"必須"以這些字結尾！ (加入了 翠、炮、寶 解決特殊命名)
VALID_SUFFIXES = ('茶', '奶', '拿鐵', '青', '綠', '紅', '烏龍', '冰沙', '鮮奶', '奶蓋', '瑪奇朵', '歐蕾', '飲', '露', '汁', '香', '寶', '多多', '牛奶', '蕎麥', '咖啡', '美式', '翡翠', '翠', '炮', '冬瓜', '仙草', '愛玉', '豆漿', '燕麥', 'Q', '果', '冰', '凍', '檸', '柚', '莓', '梅', '蘋', '桔', '普洱')

# 🗑️ 行銷廢話與獎項黑名單 (只要含有這些字，直接當垃圾丟掉)
BLACK_LIST = ['買一送一', '優惠', '推薦', '新品', '限定', '手搖', '飲料', '新上市', '回歸', '美食', '台北', '台中', '高雄', '門市', '活動', '加碼', '日常', '口感', '滋味', '好喝', '限時', '開賣', '特調', '香醇', '研磨', '嚴選', '風味', '獨家', '甜蜜', '柔軟', '全台', '上市', '聯名', '專屬', '清爽', '精油', '天花板', '隱藏版', '超值組合', '訂', '電影', '作品', '好友日', '好茶', '專賣店', '搭配', '開局', '倒數', '小編', '好心情', '大杯', '中杯', '免費', '半價', '折扣', '折價', '飲品', '好物', '品牌', '時光', '系列', '甜室', '神隊友', '大推', '首選', '必點', '果醬', '手工', '配料', '加料', '粉', '糖漿', '周邊', '提袋', '保溫杯', 'iTQi', 'itqi', 'ITQI', '得獎', '星級', '評鑑', '大賞', '時間', '相聚']

# ✂️ 前綴雜訊刪除
PREFIX_BLACKLIST = ['來杯', '這杯', '一杯', '喝杯', '杯', '推薦', '超愛', '品嚐', '想喝', '大推', '必喝', '滿滿', '全新', '推出', '超人氣', '人氣', '熱賣', '限量', '專屬', '的', '喝', '是', '點', '最愛']

# 🚫 泛用語黑名單 (專殺假飲料)
GENERIC_TERMS = ['無糖茶', '台灣茶', '下午茶', '好茶', '純茶', '精品茶', '本位製茶', '世界三大紅茶', '新年喝好茶', '英國茶', '台灣四大名茶', '熱飲', '冷飲', '冰飲', '玫瑰水', '葡萄柚系列', '綠茶專賣店', '經典回歸', '雙饗茶會', '以茶相聚', '單品紅', '原茶', '能量飲', '特調茶', '手搖飲', '咖啡日']

# ==========================================
# 2. 核心分析函式
# ==========================================
def load_menu_dict(file_path):
    menu = {}
    if not os.path.exists(file_path): return menu
    try:
        df = pd.read_excel(file_path).fillna('')
        for _, row in df.iterrows():
            brand = str(row.get('brand', '')).strip()
            item = str(row.get('item_name', '')).strip()
            if not brand or not item: continue
            db_brand = BRAND_MAP.get(brand, brand)
            if db_brand not in menu: menu[db_brand] = []
            menu[db_brand].append(item)
    except: pass
    return menu

def fix_ocr_typos(text_str):
    return text_str.replace('鳥龍', '烏龍').replace('烏能', '烏龍').replace('黑霸鳥', '黑霸烏')

def clean_and_validate(name):
    """【字尾基因鎖過濾器】保證殺死下午茶時間與iTQi"""
    name = re.sub(r'[^\u4e00-\u9fa5a-zA-Z0-9]', '', name)
    name = re.sub(r'[0-9]+[元塊]$', '', name) 
    
    # 清除品牌名稱
    for b in sorted(BRAND_EXCLUDE, key=len, reverse=True): 
        name = name.replace(b, "")
    
    # 剝除前綴
    while True:
        changed = False
        for p in PREFIX_BLACKLIST:
            if name.startswith(p):
                name = name[len(p):]
                changed = True
        if not changed: break
        
    # 剝除後綴語氣詞
    stop_words = ['內', '了', '啊', '吧', '喔', '嗎', '呢', '的', '啦', '登場', '開賣', '喝', '系列', '來了', '上市', '杯', '專賣', '大賞', '評鑑']
    while True:
        changed = False
        for sw in stop_words:
            if name.endswith(sw):
                name = name[:-len(sw)]
                changed = True
        if not changed: break

    # 1. 檢查長度
    if not (2 <= len(name) <= 12): return None
    # 2. 黑名單檢查
    if any(b.lower() in name.lower() for b in BLACK_LIST): return None
    # 3. 泛用語檢查
    if name in GENERIC_TERMS: return None
    # 4. 🥇 終極字尾檢查：必須以有效的飲料字眼"結尾"！
    # 這會直接殺死 "下午茶時間"(間結尾)、"咖啡日"(日結尾)、"iTQi"(i結尾)
    if not any(name.endswith(s) for s in VALID_SUFFIXES): return None
    
    return name

def extract_text_drinks(text_content, store_name, menu_dict):
    found = set()
    clean_text = text_content.replace(' ', '').replace('\n', '')
    
    # 1. 字典絕對對齊 (最優先)
    if store_name in menu_dict:
        for prod in sorted(menu_dict[store_name], key=len, reverse=True):
            if prod.replace(" ", "") in clean_text:
                found.add(prod)
                
    # 2. 抓取 Hashtag
    hashtags = re.findall(r'#([^\s#，。！？、；：「」【】()]+)', text_content)
    for tag in hashtags:
        valid_name = clean_and_validate(tag)
        if valid_name: found.add(valid_name)
                
    # 3. 抓取引號括號
    quotes = re.findall(r'[「『《【(（](.*?)[」』》】)）]', text_content)
    for q in quotes:
        valid_name = clean_and_validate(q)
        if valid_name: found.add(valid_name)
                
    return list(found)

def parse_pdf_visual_order(file_path, platform, store_mapping, menu_dict):
    if not os.path.exists(file_path): return []
    doc = fitz.open(file_path)
    posts, current_store_id, current_post = [], None, None
    header_pattern = re.compile(r'(\d{4}[-/\.]\d{1,2}[-/\.]\d{1,2}).*?(按讚數|讚|Like)[：:\s]*(\d+)', re.IGNORECASE)
    id_to_store_name = {v: k for k, v in store_mapping.items()}

    for page_num in range(len(doc)):
        page = doc[page_num]
        blocks = page.get_text("dict")["blocks"]
        blocks.sort(key=lambda b: b["bbox"][1])
        
        for b in blocks:
            if b["type"] == 0:
                text_content = ""
                for line in b["lines"]:
                    for span in line["spans"]: text_content += span["text"]
                    text_content += "\n"
                
                line_text = text_content.strip()
                if not line_text: continue

                is_store_header = False
                for name, sid in store_mapping.items():
                    if name in line_text and len(line_text) < 20:
                        current_store_id, is_store_header = sid, True
                        break
                if is_store_header: continue

                norm_line = unicodedata.normalize('NFKC', line_text)
                match = header_pattern.search(norm_line)
                if match:
                    if current_post: posts.append(current_post)
                    current_post = {
                        "store_id": current_store_id, "platform": platform,
                        "created_at": match.group(1).replace('/', '-').replace('.', '-'),
                        "Like": int(match.group(3)), "text_lines": [], "ocr_list": []
                    }
                elif current_post:
                    current_post["text_lines"].append(line_text)

            elif b["type"] == 1:
                if current_post:
                    try:
                        img_bytes = b["image"]
                        res = reader.readtext(img_bytes, detail=0)
                        current_post["ocr_list"].extend(res)
                    except: pass

    if current_post: posts.append(current_post)

    final_results = []
    for p in posts:
        if not p['store_id']: continue
        raw_text = "\n".join(p['text_lines'])
        store_name = id_to_store_name.get(p['store_id'])
        
        # 🎯 第一步：文案萃取
        found_drinks = set(extract_text_drinks(raw_text, store_name, menu_dict))
        source_tag = "[Text]"
        
        # 🎯 第二步：OCR 圖片補救
        if not found_drinks and p['ocr_list']:
            source_tag = "[OCR]"
            for block in p['ocr_list']:
                fixed_block = fix_ocr_typos(block)
                matched_menu = False
                
                # 優先比對字典
                if store_name in menu_dict:
                    for prod in sorted(menu_dict[store_name], key=len, reverse=True):
                        if prod.replace(" ", "") in fixed_block.replace(" ", ""):
                            found_drinks.add(prod)
                            matched_menu = True
                
                # 字典沒有，進入基因字尾檢測
                if not matched_menu:
                    valid_name = clean_and_validate(fixed_block)
                    if valid_name:
                        found_drinks.add(valid_name)

        # 🌟 平坦化處理
        if not found_drinks:
            final_results.append({
                "store_id": p['store_id'], "platform": p['platform'],
                "product_name": "[需人工確認] 圖片限定或無飲品",
                "final_text": raw_text,
                "created_at": p['created_at'], "Like": p['Like']
            })
        else:
            for d in sorted(list(found_drinks), key=len, reverse=True)[:5]:
                final_results.append({
                    "store_id": p['store_id'], "platform": p['platform'],
                    "product_name": f"{source_tag} {d}",
                    "final_text": raw_text,
                    "created_at": p['created_at'], "Like": p['Like']
                })
    return final_results

# ==========================================
# 3. 主程式執行
# ==========================================
def main():
    print("🚀 啟動【黃金字尾鎖】潔癖管線...")
    menu_dict = load_menu_dict("beverage_with_fruit_column.xlsx")

    with engine.begin() as conn:
        conn.execute(text("DROP TABLE IF EXISTS marketing_content CASCADE;"))
        conn.execute(text("DROP TABLE IF EXISTS store CASCADE;"))
        conn.execute(text("CREATE TABLE store (id INTEGER PRIMARY KEY, tenant_id INTEGER, name VARCHAR(100), location_city VARCHAR(50));"))
        
        conn.execute(text("""
            CREATE TABLE marketing_content (
                id SERIAL PRIMARY KEY,
                store_id INTEGER REFERENCES store(id),
                platform VARCHAR(50),
                product_name VARCHAR(255),
                final_text TEXT,
                created_at TIMESTAMP,
                "Like" INTEGER
            );
        """))

        store_map = {name: i for i, name in enumerate(STORE_NAMES, 1)}
        for name, sid in store_map.items():
            conn.execute(text("INSERT INTO store (id, tenant_id, name, location_city) VALUES (:id, 1, :name, '台北市')"), {"id": sid, "name": name})
        
        for plat, file in [("FB", "飲料文案fb.pdf"), ("IG", "飲料文案ig.pdf")]:
            if not os.path.exists(file): continue
            
            results = parse_pdf_visual_order(file, plat, store_map, menu_dict)
            for p in results:
                conn.execute(text("""
                    INSERT INTO marketing_content (store_id, platform, product_name, final_text, created_at, "Like")
                    VALUES (:store_id, :platform, :product_name, :final_text, CAST(:created_at AS TIMESTAMP), :Like)
                """), {"store_id": p['store_id'], "platform": p['platform'], "product_name": p['product_name'], "final_text": p['final_text'], "created_at": p['created_at'], "Like": p['Like']})
                    
    print("🎉 匯入完成！『下午茶時間』與『iTQi』等雜訊已被終結！")

if __name__ == "__main__":
    main()