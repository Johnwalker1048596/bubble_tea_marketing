"""內容圖片模型"""
import uuid
from datetime import datetime
from extensions import db
from sqlalchemy.dialects.postgresql import UUID


class ContentImage(db.Model):
    """
    內容圖片模型
    
    儲存 AI 生成的圖片資訊
    圖片實際檔案存放在 MinIO
    """
    __tablename__ = 'content_images'
    
    id = db.Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    content_id = db.Column(UUID(as_uuid=True), db.ForeignKey('marketing_contents.id'), nullable=False)
    
    # 圖片資訊
    image_url = db.Column(db.String(500), nullable=False, comment='圖片 URL (MinIO)')
    thumbnail_url = db.Column(db.String(500), comment='縮圖 URL')
    
    # AI 生成相關
    prompt_used = db.Column(db.Text, comment='使用的 AI 圖片 Prompt')
    model_used = db.Column(db.String(50), comment='使用的 AI 模型')
    
    # 圖片屬性
    width = db.Column(db.Integer, comment='寬度')
    height = db.Column(db.Integer, comment='高度')
    file_size = db.Column(db.Integer, comment='檔案大小 (bytes)')
    mime_type = db.Column(db.String(50), default='image/png', comment='MIME 類型')
    
    # 狀態
    is_primary = db.Column(db.Boolean, default=False, comment='是否為主圖')
    sort_order = db.Column(db.Integer, default=0, comment='排序順序')
    
    # 時間戳記
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    
    # Relationships
    content = db.relationship('MarketingContent', back_populates='images')
    
    def __repr__(self):
        return f'<ContentImage {self.id}>'
    
    def to_dict(self):
        return {
            'id': str(self.id),
            'content_id': str(self.content_id),
            'image_url': self.image_url,
            'thumbnail_url': self.thumbnail_url,
            'prompt_used': self.prompt_used,
            'width': self.width,
            'height': self.height,
            'file_size': self.file_size,
            'is_primary': self.is_primary,
            'created_at': self.created_at.isoformat() if self.created_at else None
        }
