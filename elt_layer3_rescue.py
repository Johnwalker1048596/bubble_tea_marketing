import pandas as pd
from sqlalchemy import create_engine, text
import re

# ==========================================
# 1. 環境初始化 & 救援設定
# ==========================================
DB_URL = "postgresql://postgres:postgres@localhost:5432/bubble_tea"
engine = create_engine(DB_URL)

# 🛟 【特種救援名單】：專救那些名字太長、太怪，且小編忘記加標籤的飲料
RESCUE_DICT = [
    '青檸甘蔗蕎麥綠寶', '星桃樂翡翠', '蕎麥綠國寶', '羽衣甘藍', 
    '百香雙響炮', '葡萄柚多多', '鮮柚綠', '草莓優格飲', '翡翠莓香'
]

# 🎯 【動作驅動特徵】：小編最愛用的動詞前綴
ACTION_VERBS = ['來杯', '喝杯', '這杯', '推薦', '必喝', '喝', '點']
# 允許的飲料結尾 (跟第二層一致，確保不會抓到廢話)
VALID_SUFFIXES = ('茶', '奶', '拿鐵', '青', '綠', '紅', '烏龍', '冰沙', '鮮奶', '奶蓋', '瑪奇朵', '歐蕾', '飲', '露', '汁', '香', '寶', '多多', '牛奶', '蕎麥', '咖啡', '美式', '翡翠', '翠', '炮', '冬瓜', '仙草', '愛玉', '豆漿', '燕麥', 'Q', '果', '冰', '凍', '檸', '柚', '莓', '梅', '蘋', '桔', '普洱')

# ==========================================
# 2. 救援邏輯
# ==========================================
def perform_rescue(final_text):
    rescued_drinks = set()
    clean_text = final_text.replace('\n', '').replace(' ', '')
    
    # 策略 A：特種救援名單 (暴力比對)
    for drink in RESCUE_DICT:
        if drink in clean_text:
            rescued_drinks.add(drink)
            
    # 策略 B：動作驅動掃描 (例如：尋找 "來杯(OOO奶茶)")
    if not rescued_drinks:
        for verb in ACTION_VERBS:
            # 尋找 動詞 開頭，長度 2~8 字，並以合法字尾結束的詞塊
            pattern = f"{verb}([\u4e00-\u9fa5a-zA-Z0-9]{{2,8}}?)(?:{'|'.join(VALID_SUFFIXES)})"
            matches = re.finditer(pattern, clean_text)
            for match in matches:
                # 把找到的詞 + 它的合法字尾 組合起來
                full_drink_name = match.group(1) + clean_text[match.end()-1] 
                # 基本防呆：確保沒有包含逗號或句號等標點符號的錯讀
                if not any(p in full_drink_name for p in ['，', '。', '！', '？', '、']):
                    rescued_drinks.add(full_drink_name)

    return list(rescued_drinks)

# ==========================================
# 3. 執行資料庫救援
# ==========================================
def run_layer3_rescue():
    print("🚁 啟動 ELT 第三層：空值特種救援行動...")
    
    with engine.connect() as conn:
        # 🎯 只撈出那些目前是「空值 (需人工確認)」的資料
        df = pd.read_sql(text("""
            SELECT id, final_text, store_id, platform, created_at, "Like" 
            FROM marketing_content 
            WHERE product_name LIKE '%需人工確認%'
        """), conn)
        
        updates = []
        new_inserts = []

        for _, row in df.iterrows():
            pid = row['id']
            final_text = row['final_text']
            
            rescued = perform_rescue(final_text)
            
            if rescued:
                # 救回的第一杯，直接 UPDATE 蓋掉目前的空值
                updates.append({"id": pid, "product_name": f"[Rescued] {rescued[0]}"})
                
                # 如果同一篇文案居然救回了第二杯以上，則 INSERT 新資料 (維持你最愛的平坦化結構)
                if len(rescued) > 1:
                    for extra_drink in rescued[1:]:
                        new_inserts.append({
                            "store_id": int(row['store_id']),
                            "platform": row['platform'],
                            "product_name": f"[Rescued] {extra_drink}",
                            "final_text": final_text,
                            "created_at": row['created_at'],
                            "Like": int(row['Like'])
                        })

        # 將救援成果寫回 PostgreSQL
        if updates or new_inserts:
            with engine.begin() as tx:
                for u in updates:
                    tx.execute(text("UPDATE marketing_content SET product_name = :pname WHERE id = :id"), 
                               {"pname": u['product_name'], "id": u['id']})
                    print(f"✨ 成功從空值中救回 ID {u['id']} -> {u['product_name']}")
                
                for ins in new_inserts:
                    tx.execute(text("""
                        INSERT INTO marketing_content (store_id, platform, product_name, final_text, created_at, "Like")
                        VALUES (:store_id, :platform, :product_name, :final_text, :created_at, :Like)
                    """), ins)
                    print(f"🛟 額外救援寫入 -> {ins['product_name']}")
                    
            print(f"\n🎉 救援大成功！共修復了 {len(updates)} 筆空值，並額外提取 {len(new_inserts)} 杯隱藏飲品。")
        else:
            print("\n✅ 掃描完畢，剩下的空值真的沒有隱藏的飲料了，必須由人工看圖處理。")

if __name__ == "__main__":
    run_layer3_rescue()