import pandas as pd
from sqlalchemy import create_engine, text

# --- 設定區 ---
excel_file = "beverage_with_fruit_column.xlsx"
db_url = "postgresql://postgres:postgres@localhost:5432/bubble_tea"

# --- 主程式 ---
def import_excel_to_db():
    try:
        print(f"📂 正在讀取 Excel: {excel_file} ...")
        
        df = pd.read_excel(excel_file)
        # 清理欄位名稱
        df.columns = [c.strip() for c in df.columns]
        
        print(f"✅ 讀取成功！共有 {len(df)} 筆資料")

        engine = create_engine(db_url)
        conn = engine.connect()
        trans = conn.begin() # 開啟交易

        print("✅ 資料庫連線成功！開始匯入...")
        count_new_products = 0
        
        for index, row in df.iterrows():
            try:
                # 1. 取得資料
                brand_name = str(row.get('brand', '')).strip()
                product_name = str(row.get('item_name', '')).strip()
                price = 0
                category_val = str(row.get('category', '一般')).strip()
                
                # 原料與水果欄位合併處理
                raw_ingredients = str(row.get('ingredients', '')).replace('、', ',').split(',')
                raw_fruits = str(row.get('水果', '')).replace('、', ',').split(',')
                
                all_ingredients = set()
                for item in raw_ingredients + raw_fruits:
                    item = item.strip()
                    if item and item != '無' and item != 'nan':
                        all_ingredients.add(item)

                if not brand_name or not product_name:
                    continue

                # 2. 處理 Tenant (品牌)
                sql_find_tenant = text("SELECT id FROM tenant WHERE name = :name")
                result = conn.execute(sql_find_tenant, {"name": brand_name}).fetchone()
                
                if result:
                    tenant_id = result[0]
                else:
                    sql_add_tenant = text("INSERT INTO tenant (name, is_registered) VALUES (:name, true) RETURNING id")
                    tenant_id = conn.execute(sql_add_tenant, {"name": brand_name}).scalar()
                    # 順便建總店
                    conn.execute(text("INSERT INTO store (tenant_id, name, location_city) VALUES (:tid, '總店', '台北市')"), {"tid": tenant_id})

                # 3. 處理 Product (飲料)
                sql_find_product = text("SELECT id FROM product WHERE name = :name AND tenant_id = :tid")
                prod_result = conn.execute(sql_find_product, {"name": product_name, "tid": tenant_id}).fetchone()
                
                if prod_result:
                    product_id = prod_result[0]
                else:
                    # [修正重點] 這裡的參數名稱 :category 要跟下面字典裡的 "category" 一樣
                    sql_add_product = text("""
                        INSERT INTO product (tenant_id, name, price, category, scraped_at) 
                        VALUES (:tid, :name, :price, :category, NOW()) 
                        RETURNING id
                    """)
                    product_id = conn.execute(sql_add_product, {
                        "tid": tenant_id, 
                        "name": product_name, 
                        "price": price, 
                        "category": category_val # 👈 這裡修正對應了！
                    }).scalar()
                    count_new_products += 1

                # 4. 處理 Ingredients (原料) & Composition
                for ing_name in all_ingredients:
                    # 找原料 ID
                    sql_find_ing = text("SELECT id FROM ingredient WHERE name = :name AND tenant_id = :tid")
                    ing_res = conn.execute(sql_find_ing, {"name": ing_name, "tid": tenant_id}).fetchone()
                    
                    if ing_res:
                        ing_id = ing_res[0]
                    else:
                        sql_add_ing = text("INSERT INTO ingredient (tenant_id, name) VALUES (:tid, :name) RETURNING id")
                        ing_id = conn.execute(sql_add_ing, {"tid": tenant_id, "name": ing_name}).scalar()
                    
                    # 建立關聯
                    sql_check_comp = text("SELECT id FROM product_composition WHERE product_id = :pid AND ingredient_id = :iid")
                    if not conn.execute(sql_check_comp, {"pid": product_id, "iid": ing_id}).fetchone():
                        conn.execute(text("INSERT INTO product_composition (product_id, ingredient_id) VALUES (:pid, :iid)"), 
                                     {"pid": product_id, "iid": ing_id})

            except Exception as e:
                print(f"⚠️ Error at row {index}: {e}")

        trans.commit()
        print(f"🎉 匯入完成！新增了 {count_new_products} 個新產品。")
        
    except Exception as e:
        print(f"❌ 發生錯誤: {e}")
    finally:
        if 'conn' in locals():
            conn.close()

if __name__ == "__main__":
    import_excel_to_db()