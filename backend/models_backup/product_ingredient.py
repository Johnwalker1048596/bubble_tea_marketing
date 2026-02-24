"""產品配方關聯表"""
import uuid
from extensions import db
from sqlalchemy.dialects.postgresql import UUID


class ProductIngredient(db.Model):
    """
    產品-原物料關聯表（配方）
    
    記錄每個產品使用哪些原物料及用量
    用於自動計算產品成本
    """
    __tablename__ = 'product_ingredients'
    
    id = db.Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    product_id = db.Column(UUID(as_uuid=True), db.ForeignKey('products.id'), nullable=False)
    ingredient_id = db.Column(UUID(as_uuid=True), db.ForeignKey('ingredients.id'), nullable=False)
    
    # 用量
    quantity = db.Column(db.Numeric(10, 4), nullable=False, comment='使用量（依原物料單位）')
    
    # Relationships
    product = db.relationship('Product', back_populates='ingredients')
    ingredient = db.relationship('Ingredient', back_populates='product_ingredients')
    
    # 確保同一產品不會重複加入同一原物料
    __table_args__ = (
        db.UniqueConstraint('product_id', 'ingredient_id', name='uq_product_ingredient'),
    )
    
    def __repr__(self):
        return f'<ProductIngredient {self.product_id} - {self.ingredient_id}>'
    
    @property
    def cost(self):
        """計算此配方項目的成本"""
        if self.ingredient and self.ingredient.unit_cost:
            return float(self.quantity * self.ingredient.unit_cost)
        return 0
    
    def to_dict(self):
        return {
            'id': str(self.id),
            'product_id': str(self.product_id),
            'ingredient_id': str(self.ingredient_id),
            'ingredient_name': self.ingredient.name if self.ingredient else None,
            'ingredient_unit': self.ingredient.unit if self.ingredient else None,
            'quantity': float(self.quantity),
            'cost': self.cost
        }
