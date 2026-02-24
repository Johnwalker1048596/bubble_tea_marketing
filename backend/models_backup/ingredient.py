"""原物料模型"""
import uuid
from datetime import datetime
from extensions import db
from sqlalchemy.dialects.postgresql import UUID


class Ingredient(db.Model):
    """
    原物料模型
    
    用於追蹤成本和庫存管理
    """
    __tablename__ = 'ingredients'
    
    id = db.Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    store_id = db.Column(UUID(as_uuid=True), db.ForeignKey('stores.id'), nullable=False)
    
    # 原物料資訊
    name = db.Column(db.String(100), nullable=False, comment='原物料名稱')
    category = db.Column(db.String(50), comment='分類: 茶葉, 糖, 奶, 配料')
    unit = db.Column(db.String(20), nullable=False, comment='單位: kg, L, 個')
    unit_cost = db.Column(db.Numeric(10, 2), nullable=False, comment='單位成本')
    
    # 庫存資訊（可選）
    stock_quantity = db.Column(db.Numeric(10, 2), default=0, comment='庫存數量')
    low_stock_threshold = db.Column(db.Numeric(10, 2), comment='低庫存警示門檻')
    
    # 狀態
    is_active = db.Column(db.Boolean, default=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    store = db.relationship('Store', back_populates='ingredients')
    product_ingredients = db.relationship('ProductIngredient', back_populates='ingredient')
    
    def __repr__(self):
        return f'<Ingredient {self.name}>'
    
    @property
    def is_low_stock(self):
        """檢查是否低庫存"""
        if self.low_stock_threshold and self.stock_quantity:
            return self.stock_quantity <= self.low_stock_threshold
        return False
    
    def to_dict(self):
        return {
            'id': str(self.id),
            'store_id': str(self.store_id),
            'name': self.name,
            'category': self.category,
            'unit': self.unit,
            'unit_cost': float(self.unit_cost) if self.unit_cost else None,
            'stock_quantity': float(self.stock_quantity) if self.stock_quantity else None,
            'is_low_stock': self.is_low_stock,
            'is_active': self.is_active,
            'created_at': self.created_at.isoformat() if self.created_at else None
        }
