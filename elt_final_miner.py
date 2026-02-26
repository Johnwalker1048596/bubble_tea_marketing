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

BRAND_EXCLUDE = ["功夫茶", "KUNGFUTEA", "大茗本位制茶堂", "大茗本位製茶堂", "本位製茶堂", "本位制茶堂", "大茗", "本位製茶", "DAMING", "得正", "先喝道", "清新福全", "清心福全", "迷客夏", "迷克夏", "MILKSHA", "COMEBUY", "龜記", "GUIJI", "五十嵐", "50嵐", "COCO", "都可"]

VALID_SUFFIXES = ('茶', '奶', '拿鐵', '青', '綠', '紅', '烏龍', '冰沙', '鮮奶', '奶蓋', '瑪奇朵', '歐蕾', '飲', '露', '汁', '香', '寶', '多多', '牛奶', '蕎麥', '咖啡', '美式', '翡翠', '翠', '炮', '冬瓜', '仙草', '愛玉', '豆漿', '燕麥', 'Q', '果', '冰', '凍', '檸', '柚', '莓', '梅', '蘋', '桔', '普洱', '水')

BLACK_LIST = [
    '買一送一', '優惠', '推薦', '新品', '限定', '手搖', '飲料', '新上市', '回歸', '美食', '台北', '台中', '高雄', '門市', '活動', '加碼', '日常', '口感', '滋味', '好喝', '限時', '開賣', '特調', '香醇', '研磨', '嚴選', '風味', '獨家', '甜蜜', '柔軟', '全台', '上市', '聯名', '專屬', '清爽', '精油', '天花板', '隱藏版', '超值組合', '電影', '作品', '好友日', '好茶', '專賣店', '搭配', '開局', '倒數', '小編', '好心情', '大杯', '中杯', '免費', '半價', '折扣', '折價', '飲品', '好物', '品牌', '時光', '系列', '甜室', '神隊友', '大推', '首選', '必點', '果醬', '手工', '配料', '加料', '粉', '糖漿', '無糖茶', '台灣茶', '下午茶', '純茶', '精品茶', '本位製茶', '世界三大紅茶', '新年喝好茶', '英國茶', '台灣四大名茶', '熱飲', '冷飲', '冰飲', '綠茶專賣店', '經典回歸', '雙饗茶會', '以茶相聚', '單品紅', '原茶', '能量飲', '特調茶', '米其林', '古典玫瑰園',
    '濃郁', '奶香', '得獎', '茶湯', '清香', '沁涼', '鮮果', '喝茶', '回家', '路上', '無論', '每一', '不只', '一杯', '每天', '只是',
    '草莓', '蔓越莓', '蘋果', '芒果', '葡萄柚', '檸檬', '百香果', '金桔'
]

PREFIX_STRIP = ['全民喝', '美樂蒂最愛', '最愛', '把', '來杯', '喝杯', '一杯', '這杯', '推薦', '超愛', '必喝', '全新', '人氣', '喝', '是', '點', '的']

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

def clean_chunk(chunk):
    c = chunk.strip()
    for b in sorted(BRAND_EXCLUDE, key=len, reverse=True):
        c = c.replace(b, "")
    while True:
        changed = False
        for p in PREFIX_STRIP:
            if c.startswith(p):
                c = c[len(p):]
                changed = True
        if not changed: break
    return c.strip()

def deep_mine_final_text(raw_text, store_name, menu_dict):
    found_drinks = set()
    cleaned_text = re.sub(r'[^\w\s\u4e00-\u9fa5，。！？、；：「」『』《》()（）#\n]', '', raw_text)
    
    if store_name in menu_dict:
        for valid_prod in sorted(menu_dict[store_name], key=len, reverse=True):
            if valid_prod in BRAND_EXCLUDE or valid_prod == store_name:
                continue
            if valid_prod in cleaned_text:
                found_drinks.add(valid_prod)
                
    if not found_drinks:
        chunks = re.split(r'[\s\n，。！？、；：「」『』《》()（）#]+', cleaned_text)
        for chunk in chunks:
            c = clean_chunk(chunk)
            if 2 <= len(c) <= 8 and any(c.endswith(s) for s in VALID_SUFFIXES):
                if not any(b in c for b in BLACK_LIST):
                    found_drinks.add(c)
                    
    return list(found_drinks)

# ==========================================
# 3. 執行資料庫大清洗與跨平台去重
# ==========================================
def run_deep_miner():
    print("⛏️ 啟動 ELT 終極防護網：裝甲探勘 + 安全去重...")
    menu_dict = load_menu_dict("beverage_with_fruit_column.xlsx")
    
    with engine.connect() as conn:
        # 🚨 絕對不碰 OCR，只救空值跟重審 Deep-Mined
        df = pd.read_sql(text("""
            SELECT m.id, m.final_text, s.name as store_name, m.store_id, m.platform, m.created_at, m."Like"
            FROM marketing_content m
            JOIN store s ON m.store_id = s.id
            WHERE m.product_name LIKE '%需人工確認%' 
               OR m.product_name LIKE '%Deep-Mined%'
        """), conn)
        
        updates = []
        new_inserts = []

        for _, row in df.iterrows():
            pid = row['id']
            raw_text = row['final_text']
            store_name = row['store_name']
            
            mined_drinks = deep_mine_final_text(raw_text, store_name, menu_dict)
            
            if mined_drinks:
                updates.append({"id": pid, "product_name": f"[Deep-Mined] {mined_drinks[0]}"})
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
            else:
                updates.append({"id": pid, "product_name": "[需人工確認] 圖片限定或無飲品"})

        with engine.begin() as tx:
            for u in updates:
                tx.execute(text("UPDATE marketing_content SET product_name = :pname WHERE id = :id"), 
                           {"pname": u['product_name'], "id": u['id']})
            for ins in new_inserts:
                tx.execute(text("""
                    INSERT INTO marketing_content (store_id, platform, product_name, final_text, created_at, "Like")
                    VALUES (:store_id, :platform, :product_name, :final_text, :created_at, :Like)
                """), ins)
            
            print(f"✨ 探勘寫入完成！準備執行【同平台限定】資料庫去重...")

            result = tx.execute(text("""
                DELETE FROM marketing_content a USING marketing_content b
                WHERE a.id > b.id 
                  AND a.platform = b.platform
                  AND a.store_id = b.store_id
                  AND a.final_text = b.final_text 
                  AND REGEXP_REPLACE(a.product_name, '^\\[.*?\\]\\s*', '') = REGEXP_REPLACE(b.product_name, '^\\[.*?\\]\\s*', '')
            """))
            print(f"🧹 平台安全去重完成！成功清理了 {result.rowcount} 筆重複資料。")
            print(f"🎉 全部任務執行完畢，資料庫已達最完美狀態！")

if __name__ == "__main__":
    run_deep_miner()