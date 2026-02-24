import csv
import uuid
import sys
sys.path.append('/app')

from app import create_app
from extensions import db
from models import Product, Tenant, Store

app = create_app()

def import_menu_csv(csv_file='/app/data/beverage_report.csv'):
    with app.app_context():
        with open(csv_file, 'r', encoding='utf-8-sig') as f:
            reader = csv.DictReader(f)
            rows = list(reader)
        
        print(f"📂 讀取到 {len(rows)} 筆資料")
        
        # 建立品牌 -> 分店對應
        stores = {}
        for row in rows:
            brand_name = row['brand']
            if brand_name not in stores:
                # 檢查品牌是否存在
                tenant = Tenant.query.filter_by(name=brand_name).first()
                if not tenant:
                    tenant = Tenant(
                        id=uuid.uuid4(),
                        name=brand_name,
                        plan='basic',
                        is_active=True
                    )
                    db.session.add(tenant)
                    db.session.flush()
                    print(f"✅ 建立品牌: {brand_name}")
                
                # 檢查分店是否存在
                store = Store.query.filter_by(tenant_id=tenant.id).first()
                if not store:
                    store = Store(
                        id=uuid.uuid4(),
                        tenant_id=tenant.id,
                        name=f"{brand_name} 總店"
                    )
                    db.session.add(store)
                    db.session.flush()
                    print(f"  └─ 建立分店: {store.name}")
                
                stores[brand_name] = store.id
        
        # 匯入產品
        count = 0
        for row in rows:
            existing = Product.query.filter_by(
                name=row['item_name'],
                store_id=stores[row['brand']]
            ).first()
            
            if not existing:
                price = float(row['price']) if row['price'] and row['price'] != '0' else 0
                product = Product(
                    id=uuid.uuid4(),
                    name=row['item_name'],
                    category=row['category'],
                    price=price,
                    store_id=stores[row['brand']],
                    is_active=True
                )
                db.session.add(product)
                count += 1
        
        db.session.commit()
        print(f"✅ 成功匯入 {count} 筆產品資料")
        print(f"📊 共 {len(stores)} 個品牌/分店")

if __name__ == '__main__':
    import_menu_csv()
