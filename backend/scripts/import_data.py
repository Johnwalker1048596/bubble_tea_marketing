"""
資料匯入腳本 - 等爬蟲資料來直接用
使用方式: docker-compose exec api python scripts/import_data.py
"""
import json
import sys
sys.path.append('/app')

from app import create_app
from extensions import db
from models import Product, Ingredient, Tenant, Store
from services.rag_service import RAGService

app = create_app()

def import_menu(json_file):
    """匯入菜單資料 (Howard 的爬蟲)"""
    with app.app_context():
        with open(json_file, 'r', encoding='utf-8') as f:
            menu_data = json.load(f)
        
        rag = RAGService()
        count = 0
        
        for item in menu_data:
            product = Product(
                name=item.get('name'),
                category=item.get('category'),
                price=item.get('price'),
                tenant_id=item.get('tenant_id')  # 需要對應品牌
            )
            db.session.add(product)
            db.session.flush()  # 取得 ID
            
            # 同步到 RAG 知識庫
            rag.add_product(
                product_id=str(product.id),
                name=product.name,
                description=item.get('description', ''),
                category=product.category,
                price=float(product.price) if product.price else None
            )
            count += 1
        
        db.session.commit()
        print(f"✅ 成功匯入 {count} 筆菜單資料")

def import_ingredients(json_file):
    """匯入原物料資料 (aad7a8 的爬蟲)"""
    with app.app_context():
        with open(json_file, 'r', encoding='utf-8') as f:
            data = json.load(f)
        
        count = 0
        for item in data:
            ingredient = Ingredient(
                name=item.get('name'),
                unit=item.get('unit', '公斤'),
                unit_cost=item.get('price'),
                tenant_id=item.get('tenant_id')
            )
            db.session.add(ingredient)
            count += 1
        
        db.session.commit()
        print(f"✅ 成功匯入 {count} 筆原物料資料")

def import_sample_tenant():
    """建立測試用品牌和分店"""
    with app.app_context():
        # 檢查是否已存在
        if Tenant.query.first():
            print("⚠️ 已有品牌資料，跳過")
            return
        
        # 建立測試品牌
        tenant = Tenant(name='測試茶飲店', plan='basic', is_active=True)
        db.session.add(tenant)
        db.session.flush()
        
        # 建立測試分店
        store = Store(
            name='台北總店',
            tenant_id=tenant.id,
            location_city='台北市'
        )
        db.session.add(store)
        db.session.commit()
        
        print(f"✅ 建立測試品牌: {tenant.name} (ID: {tenant.id})")
        print(f"✅ 建立測試分店: {store.name} (ID: {store.id})")

if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser(description='資料匯入工具')
    parser.add_argument('--menu', help='菜單 JSON 檔案路徑')
    parser.add_argument('--ingredients', help='原物料 JSON 檔案路徑')
    parser.add_argument('--init', action='store_true', help='建立測試品牌')
    
    args = parser.parse_args()
    
    if args.init:
        import_sample_tenant()
    if args.menu:
        import_menu(args.menu)
    if args.ingredients:
        import_ingredients(args.ingredients)
    
    if not any([args.init, args.menu, args.ingredients]):
        print("使用方式:")
        print("  --init           建立測試品牌")
        print("  --menu FILE      匯入菜單 JSON")
        print("  --ingredients FILE  匯入原物料 JSON")
