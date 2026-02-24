"""租戶模型 - 支援多租戶架構"""
import uuid
from datetime import datetime
from extensions import db
from sqlalchemy.dialects.postgresql import UUID


class Tenant(db.Model):
    """
    租戶/企業模型
    
    一個租戶可以擁有多個店家 (Store)
    用於未來擴展企業級多店管理
    """
    __tablename__ = 'tenants'
    
    id = db.Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    name = db.Column(db.String(100), nullable=False, comment='企業/租戶名稱')
    plan = db.Column(
        db.String(20), 
        nullable=False, 
        default='free',
        comment='訂閱方案: free, basic, pro, enterprise'
    )
    is_active = db.Column(db.Boolean, default=True, comment='是否啟用')
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    stores = db.relationship('Store', back_populates='tenant', lazy='dynamic', cascade='all, delete-orphan')
    
    def __repr__(self):
        return f'<Tenant {self.name}>'
    
    def to_dict(self):
        return {
            'id': str(self.id),
            'name': self.name,
            'plan': self.plan,
            'is_active': self.is_active,
            'created_at': self.created_at.isoformat() if self.created_at else None,
            'store_count': self.stores.count()
        }
