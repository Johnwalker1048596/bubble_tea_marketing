"""產品模型"""
import uuid
from datetime import datetime
from decimal import Decimal
from extensions import db
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy import event


class Product(db.Model):
    """
    產品模型
    
    - 屬於一個店家
    - 可包含多個原物料配方
    - 自動計算成本
    """
    __tablename__ = 'products'
    
    id = db.Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    store_id = db.Column(UUID(as_uuid=True), db.ForeignKey('stores.id'), nullable=False)
    
    # 產品資訊
    name = db.Column(db.String(100), nullable=False, comment='產品名稱')
    category = db.Column(db.String(50), comment='分類: 茶類, 奶茶, 果茶, 特調')
    description = db.Column(db.Text, comment='產品描述')
    image_url = db.Column(db.String(500), comment='產品圖片')
    
    # 價格與成本
    price = db.Column(db.Numeric(10, 2), nullable=False, comment='售價')
    cost = db.Column(db.Numeric(10, 2), default=0, comment='成本（自動計算）')
    
    # 狀態
    is_active = db.Column(db.Boolean, default=True, comment='是否上架')
    is_featured = db.Column(db.Boolean, default=False, comment='是否為推薦商品')
    
    # 時間戳記
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    store = db.relationship('Store', back_populates='products')
    ingredients = db.relationship(
        'ProductIngredient', 
        back_populates='product', 
        cascade='all, delete-orphan',
        lazy='joined'
    )
    
    def __repr__(self):
        return f'<Product {self.name}>'
    
    @property
    def profit_margin(self):
        """計算毛利率"""
        if self.price and self.price > 0:
            return float((self.price - (self.cost or 0)) / self.price)
        return 0
    
    def calculate_cost(self):
        """根據配方計算成本"""
        total_cost = Decimal('0')
        for pi in self.ingredients:
            if pi.ingredient and pi.ingredient.unit_cost:
                total_cost += pi.quantity * pi.ingredient.unit_cost
        self.cost = total_cost
        return total_cost
    
    def to_dict(self, include_ingredients=False):
        data = {
            'id': str(self.id),
            'store_id': str(self.store_id),
            'name': self.name,
            'category': self.category,
            'description': self.description,
            'image_url': self.image_url,
            'price': float(self.price) if self.price else None,
            'cost': float(self.cost) if self.cost else None,
            'profit_margin': round(self.profit_margin, 2),
            'is_active': self.is_active,
            'is_featured': self.is_featured,
            'created_at': self.created_at.isoformat() if self.created_at else None
        }
        if include_ingredients:
            data['ingredients'] = [pi.to_dict() for pi in self.ingredients]
        return data
