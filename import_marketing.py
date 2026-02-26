import os
import re
import unicodedata
import pandas as pd  
from docx import Document
from sqlalchemy import create_engine, text

# 1. 資料庫連線
DB_URL = "postgresql://postgres:postgres@localhost:5432/bubble_tea"
engine = create_engine(DB_URL)

# 2. 定義 10 間品牌
STORE_NAMES = [
    "功夫茶", "大茗本位制茶堂", "得正", "先喝道", "清新福全",
    "迷克夏", "Comebuy", "龜記", "五十嵐", "Coco都可"
]

# 建立品牌與資料庫品牌的對照表
BRAND_MAP = {
    "功夫茶": "功夫茶",
    "大茗": "大茗本位制茶堂",
    "得正": "得正",
    "先喝道": "先喝道",
    "清心福全": "清新福全", 
    "清新福全": "清新福全",
    "迷客夏": "迷克夏",  
    "迷克夏": "迷克夏",
    "comebuy": "Comebuy",
    "龜記": "龜記",
    "50嵐": "五十嵐",
    "coco都可": "Coco都可"
}

def load_menu_dict(file_path):
    """讀取 Excel，建立菜單字典"""
    menu = {}
    if not os.path.exists(file_path):
        print(f"⚠️ 找不到菜單檔案: {file_path}，將無法精準對齊飲料名稱。")
        return menu

    try:
        df = pd.read_excel(file_path)
        df = df.fillna('')
        
        for index, row in df.iterrows():
            excel_brand = str(row.get('brand', '')).strip()
            item_name = str(row.get('item_name', '')).strip()
            
            if not excel_brand or not item_name: 
                continue
            
            db_brand = BRAND_MAP.get(excel_brand, excel_brand)
            if db_brand not in menu:
                menu[db_brand] = []
            menu[db_brand].append(item_name)
            
        print(f"✅ 成功載入 {len(menu)} 家品牌的菜單字典！")
    except Exception as e:
        print(f"❌ 讀取 Excel 發生錯誤: {e}")
        
    return menu

def parse_docx_with_menu(file_path, platform, store_mapping, menu_dict):
    if not os.path.exists(file_path): return []
    doc = Document(file_path)
    posts, current_store_id, current_post_data = [], None, None
    header_pattern = re.compile(r'(\d{4}[-/\.]\d{1,2}[-/\.]\d{1,2}).*?(按讚數|讚|Like)[：:\s]*(\d+)', re.IGNORECASE)

    id_to_store_name = {v: k for k, v in store_mapping.items()}

    for para in doc.paragraphs:
        line = para.text.strip()
        if not line: continue
        
        is_store = False
        for name, sid in store_mapping.items():
            if name in line and len(line) < 20:
                current_store_id, is_store = sid, True
                break
        if is_store: continue

        norm_line = unicodedata.normalize('NFKC', line)
        match = header_pattern.search(norm_line)
        
        if match:
            if current_post_data: posts.append(current_post_data)
            current_post_data = {
                "store_id": current_store_id, "platform": platform,
                "created_at": match.group(1).replace('/', '-').replace('.', '-'),
                "Like": int(match.group(3)), "lines": []
            }
        elif current_post_data:
            current_post_data['lines'].append(line)

    if current_post_data: posts.append(current_post_data)
    
    final_results = []
    
    # 🌟 統一集中管理黑白名單
    black_list = [
        '買一送一', '優惠', '抽獎', '推薦', '新品', '限定', '手搖', '飲料', 
        '美食', '台北', '台中', '高雄', '台灣', '打卡', '好喝', '喝起來', 
        '門市', '活動', '快樂', '節', '聯名', '上市', '開賣', '外送', '人氣',
        '必喝', '菜單', '加碼', '日常', '滋味', '口感', '系列', '試賣', '專屬',
        '新上市', '回歸', '杯'
    ]
    # 擴充了 '蘋' 與 '黑糖'
    white_list = [
        '茶', '奶', '紅', '綠', '青', '烏龍', '拿鐵', '多多', '冰沙', 
        '果', '檸檬', '珍珠', '波霸', '粉粿', '蕎麥', '春', '鐵觀音', '汁', '冰', '凍',
        '奶蓋', '歐蕾', '甘露', '瑪奇朵', '冰茶', '特調', '芝芝', '雙Q', '椰果', '寶',
        '蘋', '黑糖' 
    ]

    for p in posts:
        full_text = "\n".join(p['lines'])
        
        # 🧹 魔法淨化：在一開始就把所有隱形字元跟特殊空白全部殺掉
        full_text = full_text.replace('\u200b', '').replace('\xa0', '').replace('\u200e', '')
        
        if not full_text.strip():
            continue
            
        matched_product = None
        store_name = id_to_store_name.get(p['store_id'])
        
        # 🎯 第一關：Excel 核心對齊
        if store_name in menu_dict:
            sorted_menu = sorted(menu_dict[store_name], key=len, reverse=True)
            for prod in sorted_menu:
                if prod.replace(" ", "") in full_text.replace(" ", ""):
                    matched_product = prod
                    break
        
        # 🛡️ 第二關：Hashtag 智能抓取
        if not matched_product:
            hashtags = re.findall(r'#([^\s#，。！？、；：「」【】()]+)', full_text)
            for tag in hashtags:
                tag_clean = tag.replace('_', '').replace('-', '') 
                
                # ✨ 剝洋蔥魔法：把黑名單的字「刪除」而不是「整組報廢」
                for black_word in black_list:
                    tag_clean = tag_clean.replace(black_word, '')
                    
                if 2 <= len(tag_clean) <= 12:
                    if any(white_word in tag_clean for white_word in white_list):
                        matched_product = tag_clean
                        break
                        
        # 🚀 第三關：全文詞塊暴力掃描 (處理不加 Hashtag 的貼文)
        if not matched_product:
            chunks = re.split(r'[^\w\u4e00-\u9fa5]+', full_text)
            for chunk in chunks:
                chunk = chunk.strip()
                
                # ✨ 剝洋蔥魔法：把黑名單的字「刪除」
                for black_word in black_list:
                    chunk = chunk.replace(black_word, '')
                    
                if 2 <= len(chunk) <= 10:
                    if any(white_word in chunk for white_word in white_list):
                        matched_product = chunk
                        break

        # 🏷️ 第四關：真的抓不到，才是日常廢文
        if not matched_product:
            matched_product = "品牌日常/無特定飲品"
            
        final_results.append({
            "store_id": p['store_id'], "platform": p['platform'],
            "product_name": matched_product, "final_text": full_text,
            "created_at": p['created_at'], "Like": p['Like']
        })
    return final_results

def main():
    print("🚀 啟動菜單精準對齊匯入管線...")
    EXCEL_FILENAME = "beverage_with_fruit_column.xlsx"
    menu_dict = load_menu_dict(EXCEL_FILENAME)

    with engine.begin() as conn:
        conn.execute(text("TRUNCATE TABLE store CASCADE;"))
        store_map = {name: i for i, name in enumerate(STORE_NAMES, 1)}
        for name, sid in store_map.items():
            conn.execute(text("INSERT INTO store (id, tenant_id, name, location_city) VALUES (:id, 1, :name, '台北市')"), {"id": sid, "name": name})
        
        conn.execute(text("TRUNCATE TABLE marketing_content RESTART IDENTITY CASCADE;"))
        for plat, file in [("FB", "飲料文案fb.docx"), ("IG", "飲料文案ig.docx")]:
            for p in parse_docx_with_menu(file, plat, store_map, menu_dict):
                conn.execute(text("""INSERT INTO marketing_content (store_id, platform, product_name, final_text, created_at, "Like")
                                     VALUES (:store_id, :platform, :product_name, :final_text, CAST(:created_at AS TIMESTAMP), :Like)"""), p)
    print("🎉 資料清洗匯入完成！產品名稱已完美對齊。")

if __name__ == "__main__":
    main()