"""匯入飲品資料到新的 INT ID 資料庫"""
import csv
import sys
sys.path.insert(0, '/app')

from app import create_app
from extensions import db
from models import Tenant, Store, Product

app = create_app()

def import_data():
    with app.app_context():
        # 讀取 CSV
        brands = {}
        products_data = []
        
        with open('/app/data/beverage_report.csv', 'r', encoding='utf-8-sig') as f:
            reader = csv.DictReader(f)
            for row in reader:
                brand = row['brand']
                if brand not in brands:
                    brands[brand] = True
                products_data.append(row)
        
        print(f"找到 {len(brands)} 個品牌，{len(products_data)} 個產品")
        
        # 建立品牌 (Tenant) 和分店 (Store)
        tenant_map = {}
        for brand_name in brands.keys():
            tenant = Tenant(name=brand_name, is_registered=True, is_active=True)
            db.session.add(tenant)
            db.session.flush()
            
            store = Store(tenant_id=tenant.id, name=f"{brand_name} 總店", location_city="台北市")
            db.session.add(store)
            db.session.flush()
            
            tenant_map[brand_name] = {'tenant_id': tenant.id, 'store_id': store.id}
            print(f"✅ 建立品牌: {brand_name} (tenant_id={tenant.id}, store_id={store.id})")
        
        # 建立產品
        count = 0
        for row in products_data:
            brand = row['brand']
            price = float(row['price']) if row['price'] else 0
            
            product = Product(
                tenant_id=tenant_map[brand]['tenant_id'],
                store_id=tenant_map[brand]['store_id'],
                name=row['item_name'],
                category=row['category'],
                price=price,
                is_active=True
            )
            db.session.add(product)
            count += 1
        
        db.session.commit()
        print(f"\n✅ 成功匯入 {count} 個產品！")

if __name__ == '__main__':
    import_data()
