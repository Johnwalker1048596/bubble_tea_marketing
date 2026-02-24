"""店家模型 - 包含 Instagram 串接資訊"""
import uuid
from datetime import datetime
from extensions import db
from sqlalchemy.dialects.postgresql import UUID


class Store(db.Model):
    """
    店家模型
    
    - 屬於一個租戶 (Tenant)
    - 擁有多個使用者、產品、原物料、行銷內容
    - 包含 Instagram 串接資訊
    """
    __tablename__ = 'stores'
    
    id = db.Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    tenant_id = db.Column(UUID(as_uuid=True), db.ForeignKey('tenants.id'), nullable=False)
    
    # 基本資訊
    name = db.Column(db.String(100), nullable=False, comment='店家名稱')
    description = db.Column(db.Text, comment='店家描述')
    address = db.Column(db.String(255), comment='店家地址')
    phone = db.Column(db.String(20), comment='聯絡電話')
    
    # Instagram 串接
    ig_account = db.Column(db.String(100), comment='Instagram 帳號')
    ig_access_token = db.Column(db.Text, comment='Instagram Access Token')
    ig_token_expires_at = db.Column(db.DateTime, comment='Token 過期時間')
    ig_user_id = db.Column(db.String(50), comment='Instagram User ID')
    
    # 狀態
    is_active = db.Column(db.Boolean, default=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    tenant = db.relationship('Tenant', back_populates='stores')
    users = db.relationship('User', back_populates='store', lazy='dynamic', cascade='all, delete-orphan')
    products = db.relationship('Product', back_populates='store', lazy='dynamic', cascade='all, delete-orphan')
    ingredients = db.relationship('Ingredient', back_populates='store', lazy='dynamic', cascade='all, delete-orphan')
    marketing_contents = db.relationship('MarketingContent', back_populates='store', lazy='dynamic', cascade='all, delete-orphan')
    
    def __repr__(self):
        return f'<Store {self.name}>'
    
    @property
    def ig_connected(self):
        """檢查 Instagram 是否已連接"""
        return bool(self.ig_access_token and self.ig_user_id)
    
    def to_dict(self, include_ig_token=False):
        data = {
            'id': str(self.id),
            'tenant_id': str(self.tenant_id),
            'name': self.name,
            'description': self.description,
            'address': self.address,
            'phone': self.phone,
            'ig_account': self.ig_account,
            'ig_connected': self.ig_connected,
            'is_active': self.is_active,
            'created_at': self.created_at.isoformat() if self.created_at else None
        }
        if include_ig_token:
            data['ig_access_token'] = self.ig_access_token
        return data
