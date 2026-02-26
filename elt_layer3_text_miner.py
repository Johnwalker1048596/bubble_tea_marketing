import pandas as pd
from sqlalchemy import create_engine, text
import re
import os

# ==========================================
# 1. 環境初始化與黃金規則
# ==========================================
DB_URL = "postgresql://postgres:postgres@localhost:5432/bubble_tea"
engine = create_engine(DB_URL)

BRAND_MAP = {
    "功夫茶": "功夫茶", "大茗": "大茗本位制茶堂", "得正": "得正", "先喝道": "先喝道",
    "清心福全": "清新福全", "清新福全": "清新福全", "迷客夏": "迷克夏", "迷克夏": "迷克夏",
    "comebuy": "Comebuy", "龜記": "龜記", "50嵐": "五十嵐", "coco都可": "Coco都可"
}

# 🧬 合法飲料結尾 (增加了 '水'，因為先喝道有 '玫瑰水')
VALID_SUFFIXES = ('茶', '奶', '拿鐵', '青', '綠', '紅', '烏龍', '冰沙', '鮮奶', '奶蓋', '瑪奇朵', '歐蕾', '飲', '露', '汁', '香', '寶', '多多', '牛奶', '蕎麥', '咖啡', '美式', '翡翠', '翠', '炮', '冬瓜', '仙草', '愛玉', '豆漿', '燕麥', 'Q', '果', '冰', '凍', '檸', '柚', '莓', '梅', '蘋', '桔', '普洱', '水')

# 🚫 泛用語與廢話 (絕對不能抓)
BLACK_LIST = ['買一送一', '優惠', '推薦', '新品', '限定', '手搖', '飲料', '新上市', '回歸', '美食', '台北', '台中', '高雄', '門市', '活動', '加碼', '日常', '口感', '滋味', '好喝', '限時', '開賣', '特調', '香醇', '研磨', '嚴選', '風味', '獨家', '甜蜜', '柔軟', '全台', '上市', '聯名', '專屬', '清爽', '精油', '天花板', '隱藏版', '超值組合', '電影', '作品', '好友日', '好茶', '專賣店', '搭配', '開局', '倒數', '小編', '好心情', '大杯', '中杯', '免費', '半價', '折扣', '折價', '飲品', '好物', '品牌', '時光', '系列', '甜室', '神隊友', '大推', '首選', '必點', '果醬', '手工', '配料', '加料', '粉', '糖漿', '無糖茶', '台灣茶', '下午茶', '純茶', '精品茶', '本位製茶', '世界三大紅茶', '新年喝好茶', '英國茶', '台灣四大名茶', '熱飲', '冷飲', '冰飲', '綠茶專賣店', '經典回歸', '雙饗茶會', '以茶相聚', '單品紅', '原茶', '能量飲', '特調茶', '米其林', '古典玫瑰園']

# ==========================================
# 2. 深度探勘邏輯
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

def clean_text_for_mining(text_content):
    """清除破圖 Emoji (如 ) 與無用標點"""
    # 只保留中英文、數字、常見中文標點與換行
    clean = re.sub(r'[^\w\s\u4e00-\u9fa5，。！？、；：「」『』《》()（）#\n]', '', text_content)
    return clean

def deep_mine_final_text(raw_text, store_name, menu_dict):
    """從文案全文中進行深度探勘"""
    found_drinks = set()
    cleaned_text = clean_text_for_mining(raw_text)
    
    # 【戰術一：菜單黃金比對】 (最穩)
    # 只要文案裡出現菜單上的名字，直接抓！不管有沒有標籤。
    if store_name in menu_dict:
        # 從長度長的開始比對，避免「烏龍綠茶」被切成「綠茶」
        for valid_prod in sorted(menu_dict[store_name], key=len, reverse=True):
            if valid_prod in cleaned_text:
                found_drinks.add(valid_prod)
                
    # 【戰術二：斷句特徵掃描】 (專抓裸奔新品，如：冬韻擂焙珍奶)
    # 如果戰術一沒抓到東西（代表可能是新品）
    if not found_drinks:
        # 用標點符號、換行、空格把文章切成一塊一塊的詞
        chunks = re.split(r'[\s\n，。！？、；：「」『』《》()（）#]+', cleaned_text)
        for chunk in chunks:
            c = chunk.strip()
            # 必須長度在 2~8 字，並且以飲料字眼結尾
            if 2 <= len(c) <= 8 and any(c.endswith(s) for s in VALID_SUFFIXES):
                # 排除泛用語與廢話黑名單
                if not any(b in c for b in BLACK_LIST):
                    found_drinks.add(c)
                    
    return list(found_drinks)

# ==========================================
# 3. 執行資料庫修復
# ==========================================
def run_deep_miner():
    print("⛏️ 啟動 ELT 第三層：final_text 全文深度探勘...")
    menu_dict = load_menu_dict("beverage_with_fruit_column.xlsx")
    
    with engine.connect() as conn:
        # 把目前空值或怪怪的資料撈出來重新掃描
        df = pd.read_sql(text("""
            SELECT m.id, m.final_text, s.name as store_name, m.store_id, m.platform, m.created_at, m."Like"
            FROM marketing_content m
            JOIN store s ON m.store_id = s.id
            WHERE m.product_name LIKE '%需人工確認%' OR m.product_name LIKE '%OCR%'
        """), conn)
        
        updates = []
        new_inserts = []

        for _, row in df.iterrows():
            pid = row['id']
            raw_text = row['final_text']
            store_name = row['store_name']
            
            mined_drinks = deep_mine_final_text(raw_text, store_name, menu_dict)
            
            if mined_drinks:
                # 救回第一杯，UPDATE 覆蓋掉原本的空值
                updates.append({"id": pid, "product_name": f"[Deep-Mined] {mined_drinks[0]}"})
                
                # 如果同一篇文案挖出多杯 (例如玫瑰水、英式玫瑰拿鐵)，就 INSERT 保持平坦化
                if len(mined_drinks) > 1:
                    for extra in mined_drinks[1:]:
                        new_inserts.append({
                            "store_id": int(row['store_id']),
                            "platform": row['platform'],
                            "product_name": f"[Deep-Mined] {extra}",
                            "final_text": raw_text,
                            "created_at": row['created_at'],
                            "Like": int(row['Like'])
                        })

        if updates or new_inserts:
            with engine.begin() as tx:
                for u in updates:
                    tx.execute(text("UPDATE marketing_content SET product_name = :pname WHERE id = :id"), 
                               {"pname": u['product_name'], "id": u['id']})
                    print(f"✨ 深度探勘成功！更新 ID {u['id']} -> {u['product_name']}")
                
                for ins in new_inserts:
                    tx.execute(text("""
                        INSERT INTO marketing_content (store_id, platform, product_name, final_text, created_at, "Like")
                        VALUES (:store_id, :platform, :product_name, :final_text, :created_at, :Like)
                    """), ins)
                    print(f"🛟 深度探勘寫入新列 -> {ins['product_name']}")
                    
            print(f"\n🎉 探勘完成！共修復了 {len(updates)} 筆資料，額外提取了 {len(new_inserts)} 杯隱藏飲品！")
        else:
            print("\n✅ 探勘完畢，沒有發現可救回的資料。")

if __name__ == "__main__":
    run_deep_miner()