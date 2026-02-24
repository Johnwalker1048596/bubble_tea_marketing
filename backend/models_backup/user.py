"""使用者模型"""
import uuid
from datetime import datetime
from extensions import db
from sqlalchemy.dialects.postgresql import UUID
import bcrypt


class User(db.Model):
    """
    使用者模型
    
    角色說明:
    - owner: 店家擁有者，最高權限
    - manager: 店長，可管理內容和設定
    - staff: 員工，只能查看和建立內容
    """
    __tablename__ = 'users'
    
    id = db.Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    store_id = db.Column(UUID(as_uuid=True), db.ForeignKey('stores.id'), nullable=False)
    
    # 認證資訊
    email = db.Column(db.String(255), unique=True, nullable=False, index=True)
    password_hash = db.Column(db.String(255), nullable=False)
    
    # 個人資訊
    name = db.Column(db.String(100), comment='使用者名稱')
    avatar_url = db.Column(db.String(500), comment='頭像 URL')
    
    # 角色與權限
    role = db.Column(
        db.String(20), 
        nullable=False, 
        default='staff',
        comment='角色: owner, manager, staff'
    )
    
    # 狀態
    is_active = db.Column(db.Boolean, default=True)
    last_login_at = db.Column(db.DateTime, comment='最後登入時間')
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    store = db.relationship('Store', back_populates='users')
    reviewed_contents = db.relationship('MarketingContent', back_populates='reviewer', foreign_keys='MarketingContent.reviewed_by')
    
    def __repr__(self):
        return f'<User {self.email}>'
    
    def set_password(self, password):
        """設定密碼（加密儲存）"""
        self.password_hash = bcrypt.hashpw(
            password.encode('utf-8'), 
            bcrypt.gensalt()
        ).decode('utf-8')
    
    def check_password(self, password):
        """驗證密碼"""
        return bcrypt.checkpw(
            password.encode('utf-8'), 
            self.password_hash.encode('utf-8')
        )
    
    def update_last_login(self):
        """更新最後登入時間"""
        self.last_login_at = datetime.utcnow()
        db.session.commit()
    
    @property
    def is_owner(self):
        return self.role == 'owner'
    
    @property
    def is_manager(self):
        return self.role in ('owner', 'manager')
    
    def to_dict(self):
        return {
            'id': str(self.id),
            'store_id': str(self.store_id),
            'email': self.email,
            'name': self.name,
            'avatar_url': self.avatar_url,
            'role': self.role,
            'is_active': self.is_active,
            'last_login_at': self.last_login_at.isoformat() if self.last_login_at else None,
            'created_at': self.created_at.isoformat() if self.created_at else None
        }
