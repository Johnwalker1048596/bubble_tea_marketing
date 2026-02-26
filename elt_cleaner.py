import pandas as pd
from sqlalchemy import create_engine, text
import re

# ==========================================
# 1. 資料庫連線與清洗規則字典
# ==========================================
DB_URL = "postgresql://postgres:postgres@localhost:5432/bubble_tea"
engine = create_engine(DB_URL)

# 🗑️ 第一層：直接刪除的絕對黑名單 (假飲料)
DELETE_LIST = ['英式下午茶', '茶飲', '咖啡', '馥郁焦糖香', '美好雙果', '台灣茶', '下午茶', '綠茶', '紅茶', '烏龍']

# 🩹 第二層：錯字與智障 OCR 替換字典
TYPO_FIXES = {
    '草垚': '草莓',
    '鳥龍': '烏龍',
    '烏能': '烏龍',
    '黑霸鳥': '黑霸烏'
}

# ✂️ 第三層：前綴廢話裁切刀
PREFIX_STRIP = ['莓好新年必喝', '來杯', '一杯', '這杯', '推薦', '超愛', '必喝', '全新', '人氣']

# 🛟 第四層：精準救援字典 (專救那些被遺漏的長名字特殊飲料)
# 如果 final_text 包含 Key，就把 Value 救回 product_name
RESCUE_DICT = {
    '青檸甘蔗蕎麥綠寶': '青檸甘蔗蕎麥綠寶',
    '星桃樂翡翠': '星桃樂翡翠',
    '羽衣': '羽衣甘藍', 
    '百香雙響炮': '百香雙響炮',
    '莓好雙果茶': '莓好雙果茶',
    '珍波椰青茶': '珍波椰青茶',
    '綠國寶': '蕎麥綠國寶'
}

# ==========================================
# 2. 清洗邏輯
# ==========================================
def clean_product_name(raw_name):
    """清洗已抓取的飲料名稱"""
    # 提取標籤 [Text] 或 [OCR]
    tag_match = re.search(r'(\[.*?\])', raw_name)
    tag = tag_match.group(1) + " " if tag_match else "[Cleaned] "
    clean_name = re.sub(r'\[.*?\]\s*', '', raw_name).strip()

    # 1. 殺死黑名單
    if clean_name in DELETE_LIST:
        return "[需人工確認] 圖片限定或無飲品"

    # 2. 修復錯字
    for bad, good in TYPO_FIXES.items():
        clean_name = clean_name.replace(bad, good)

    # 3. 裁切廢話前綴
    while True:
        changed = False
        for p in PREFIX_STRIP:
            if clean_name.startswith(p):
                clean_name = clean_name[len(p):]
                changed = True
        if not changed: break

    # 若裁切完變太短，視為無效
    if len(clean_name) < 2:
        return "[需人工確認] 圖片限定或無飲品"

    return tag + clean_name

def rescue_from_text(final_text):
    """從文案中救援遺漏的特殊飲料"""
    rescued_drinks = []
    for keyword, correct_name in RESCUE_DICT.items():
        if keyword in final_text:
            rescued_drinks.append(f"[Text-Rescued] {correct_name}")
    return rescued_drinks

# ==========================================
# 3. 執行清洗 (ELT: Transform)
# ==========================================
def run_elt_cleaner():
    print("🧹 啟動 ELT 深度清洗與救援管線...")
    
    with engine.connect() as conn:
        df = pd.read_sql("SELECT id, product_name, final_text FROM marketing_content", conn)
        
        updates = []
        deletes = []
        new_inserts = [] # 用於存放救援成功，需要新增的行

        for _, row in df.iterrows():
            pid = row['id']
            raw_name = row['product_name']
            final_text = row['final_text']
            
            # 處理已存在的飲料名 (清洗與替換)
            if "需人工確認" not in raw_name:
                cleaned = clean_product_name(raw_name)
                if cleaned != raw_name:
                    if "需人工確認" in cleaned:
                        deletes.append(pid) # 變成空值的，等一下統一刪除或替換
                    else:
                        updates.append({"id": pid, "product_name": cleaned})
            
            # 處理留空的紀錄 (啟動救援)
            else:
                rescued = rescue_from_text(final_text)
                if rescued:
                    # 救回第一杯，直接 UPDATE 蓋掉目前的 [需人工確認]
                    updates.append({"id": pid, "product_name": rescued[0]})
                    # 如果同一篇文案救回了第二杯、第三杯，就要 INSERT 新資料 (保持平坦化)
                    if len(rescued) > 1:
                        for extra_drink in rescued[1:]:
                            # 我們需要把這篇貼文的其他資訊複製過來
                            post_info = pd.read_sql(f"SELECT store_id, platform, final_text, created_at, \"Like\" FROM marketing_content WHERE id = {pid}", conn).iloc[0]
                            new_inserts.append({
                                "store_id": int(post_info['store_id']),
                                "platform": post_info['platform'],
                                "product_name": extra_drink,
                                "final_text": post_info['final_text'],
                                "created_at": post_info['created_at'],
                                "Like": int(post_info['Like'])
                            })

        # 寫回資料庫
        with engine.begin() as tx:
            # 1. 更新清洗後的名稱與救援成功的名稱
            for u in updates:
                tx.execute(text("UPDATE marketing_content SET product_name = :pname WHERE id = :id"), 
                           {"pname": u['product_name'], "id": u['id']})
                print(f"✨ 成功修復/救援 ID {u['id']} -> {u['product_name']}")
            
            # 2. 把判定為垃圾的直接刪除 (或是你可以改成 UPDATE 為需人工確認)
            if deletes:
                tx.execute(text("DELETE FROM marketing_content WHERE id = ANY(:ids)"), {"ids": deletes})
                print(f"🗑️ 成功刪除 {len(deletes)} 筆垃圾資料 (如英式下午茶等)")
                
            # 3. 插入額外救援回來的平坦化資料
            for ins in new_inserts:
                tx.execute(text("""
                    INSERT INTO marketing_content (store_id, platform, product_name, final_text, created_at, "Like")
                    VALUES (:store_id, :platform, :product_name, :final_text, :created_at, :Like)
                """), ins)
                print(f"🛟 額外救援寫入 -> {ins['product_name']}")

    print("\n🎉 資料庫清洗完成！草垚變成草莓，青檸綠寶也成功歸隊！")

if __name__ == "__main__":
    run_elt_cleaner()