"""行銷內容模型"""
import uuid
from datetime import datetime
from extensions import db
from sqlalchemy.dialects.postgresql import UUID


class MarketingContent(db.Model):
    """
    行銷內容模型
    
    儲存 AI 生成的文案，包含：
    - 生成的文字內容
    - 天氣情境
    - 趨勢情境
    - 審核狀態
    - 發布狀態
    """
    __tablename__ = 'marketing_contents'
    
    id = db.Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    store_id = db.Column(UUID(as_uuid=True), db.ForeignKey('stores.id'), nullable=False)
    reviewed_by = db.Column(UUID(as_uuid=True), db.ForeignKey('users.id'), comment='審核者')
    
    # 關聯的產品（可選）
    product_id = db.Column(UUID(as_uuid=True), db.ForeignKey('products.id'), comment='關聯產品')
    
    # AI 生成相關
    ai_prompt = db.Column(db.Text, comment='使用的 AI Prompt')
    generated_text = db.Column(db.Text, nullable=False, comment='生成的文案')
    
    # 情境資訊
    weather_context = db.Column(db.String(100), comment='天氣情境: 32°C 晴天')
    trend_context = db.Column(db.String(255), comment='趨勢情境: #消暑 #夏日限定')
    
    # 使用者編輯的最終版本
    final_text = db.Column(db.Text, comment='編輯後的最終文案')
    
    # 狀態: draft(草稿), pending(待審核), approved(已核准), published(已發布), rejected(已拒絕)
    status = db.Column(
        db.String(20), 
        nullable=False, 
        default='draft',
        index=True,
        comment='狀態: draft, pending, approved, published, rejected'
    )
    
    # 發布資訊
    published_at = db.Column(db.DateTime, comment='發布時間')
    ig_post_id = db.Column(db.String(100), comment='Instagram 貼文 ID')
    ig_permalink = db.Column(db.String(500), comment='Instagram 貼文連結')
    
    # 時間戳記
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    store = db.relationship('Store', back_populates='marketing_contents')
    reviewer = db.relationship('User', back_populates='reviewed_contents', foreign_keys=[reviewed_by])
    product = db.relationship('Product')
    images = db.relationship('ContentImage', back_populates='content', cascade='all, delete-orphan', lazy='joined')
    
    def __repr__(self):
        return f'<MarketingContent {self.id} - {self.status}>'
    
    @property
    def display_text(self):
        """取得顯示用文案（優先使用編輯後版本）"""
        return self.final_text or self.generated_text
    
    @property
    def is_editable(self):
        """檢查是否可編輯"""
        return self.status in ('draft', 'pending', 'rejected')
    
    @property
    def is_publishable(self):
        """檢查是否可發布"""
        return self.status == 'approved'
    
    def approve(self, reviewer_id):
        """核准內容"""
        self.status = 'approved'
        self.reviewed_by = reviewer_id
        self.updated_at = datetime.utcnow()
    
    def reject(self, reviewer_id):
        """拒絕內容"""
        self.status = 'rejected'
        self.reviewed_by = reviewer_id
        self.updated_at = datetime.utcnow()
    
    def mark_published(self, ig_post_id=None, ig_permalink=None):
        """標記為已發布"""
        self.status = 'published'
        self.published_at = datetime.utcnow()
        if ig_post_id:
            self.ig_post_id = ig_post_id
        if ig_permalink:
            self.ig_permalink = ig_permalink
    
    def to_dict(self, include_images=True):
        data = {
            'id': str(self.id),
            'store_id': str(self.store_id),
            'product_id': str(self.product_id) if self.product_id else None,
            'product_name': self.product.name if self.product else None,
            'generated_text': self.generated_text,
            'final_text': self.final_text,
            'display_text': self.display_text,
            'weather_context': self.weather_context,
            'trend_context': self.trend_context,
            'status': self.status,
            'reviewed_by': str(self.reviewed_by) if self.reviewed_by else None,
            'published_at': self.published_at.isoformat() if self.published_at else None,
            'ig_post_id': self.ig_post_id,
            'ig_permalink': self.ig_permalink,
            'created_at': self.created_at.isoformat() if self.created_at else None,
            'updated_at': self.updated_at.isoformat() if self.updated_at else None
        }
        if include_images:
            data['images'] = [img.to_dict() for img in self.images]
        return data
