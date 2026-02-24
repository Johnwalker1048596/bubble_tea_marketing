"""
資料庫模型 - 符合組長設計規格（INT ID 版本）
保留所有原本的方法
"""
import bcrypt
from datetime import datetime
from decimal import Decimal
from extensions import db


# ==================== 組織與帳號 ====================

class Tenant(db.Model):
    """品牌 (tenant)"""
    __tablename__ = 'tenants'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String(100), nullable=False, comment='企業/租戶名稱')
    is_registered = db.Column(db.Boolean, default=False, comment='是否完成菜單註冊')
    plan = db.Column(db.String(20), nullable=False, default='free', comment='訂閱方案')
    is_active = db.Column(db.Boolean, default=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    stores = db.relationship('Store', back_populates='tenant', lazy='dynamic', cascade='all, delete-orphan')

    def __repr__(self):
        return f'<Tenant {self.name}>'

    def to_dict(self):
        return {
            'id': self.id,
            'name': self.name,
            'plan': self.plan,
            'is_active': self.is_active,
            'is_registered': self.is_registered,
            'created_at': self.created_at.isoformat() if self.created_at else None,
            'store_count': self.stores.count()
        }


class Store(db.Model):
    """分店 (store)"""
    __tablename__ = 'stores'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    tenant_id = db.Column(db.Integer, db.ForeignKey('tenants.id'), nullable=False)
    name = db.Column(db.String(100), nullable=False, comment='店家名稱')
    location_city = db.Column(db.String(50), comment='所在城市')
    description = db.Column(db.Text, comment='店家描述')
    address = db.Column(db.String(255), comment='店家地址')
    phone = db.Column(db.String(20), comment='聯絡電話')
    ig_account = db.Column(db.String(100), comment='Instagram 帳號')
    ig_access_token = db.Column(db.Text, comment='Instagram Access Token')
    ig_token_expires_at = db.Column(db.DateTime, comment='Token 過期時間')
    ig_user_id = db.Column(db.String(50), comment='Instagram User ID')
    is_active = db.Column(db.Boolean, default=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    tenant = db.relationship('Tenant', back_populates='stores')
    users = db.relationship('User', back_populates='store', lazy='dynamic', cascade='all, delete-orphan')
    products = db.relationship('Product', back_populates='store', lazy='dynamic', cascade='all, delete-orphan')
    ingredients = db.relationship('Ingredient', back_populates='store', lazy='dynamic', cascade='all, delete-orphan')
    marketing_contents = db.relationship('MarketingContent', back_populates='store', lazy='dynamic', cascade='all, delete-orphan')

    def __repr__(self):
        return f'<Store {self.name}>'

    @property
    def ig_connected(self):
        return bool(self.ig_access_token and self.ig_user_id)

    def to_dict(self, include_ig_token=False):
        data = {
            'id': self.id,
            'tenant_id': self.tenant_id,
            'name': self.name,
            'location_city': self.location_city,
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


class User(db.Model):
    """使用者 (user)"""
    __tablename__ = 'users'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    store_id = db.Column(db.Integer, db.ForeignKey('stores.id'), nullable=False)
    email = db.Column(db.String(255), unique=True, nullable=False, index=True)
    password_hash = db.Column(db.String(255), nullable=False)
    name = db.Column(db.String(100), comment='使用者名稱')
    avatar_url = db.Column(db.String(500), comment='頭像 URL')
    role = db.Column(db.String(20), nullable=False, default='staff', comment='角色: owner, manager, staff')
    is_active = db.Column(db.Boolean, default=True)
    last_login_at = db.Column(db.DateTime, comment='最後登入時間')
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    store = db.relationship('Store', back_populates='users')
    reviewed_contents = db.relationship('MarketingContent', back_populates='reviewer', foreign_keys='MarketingContent.reviewed_by')

    def __repr__(self):
        return f'<User {self.email}>'

    def set_password(self, password):
        self.password_hash = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')

    def check_password(self, password):
        return bcrypt.checkpw(password.encode('utf-8'), self.password_hash.encode('utf-8'))

    def update_last_login(self):
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
            'id': self.id,
            'store_id': self.store_id,
            'email': self.email,
            'name': self.name,
            'avatar_url': self.avatar_url,
            'role': self.role,
            'is_active': self.is_active,
            'last_login_at': self.last_login_at.isoformat() if self.last_login_at else None,
            'created_at': self.created_at.isoformat() if self.created_at else None
        }


# ==================== 菜單與動態原物料 ====================

class Product(db.Model):
    """飲品 (product)"""
    __tablename__ = 'product'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    tenant_id = db.Column(db.Integer, db.ForeignKey('tenants.id'), nullable=False)
    store_id = db.Column(db.Integer, db.ForeignKey('stores.id'))
    name = db.Column(db.String(100), nullable=False, comment='產品名稱')
    category = db.Column(db.String(50), comment='分類')
    description = db.Column(db.Text, comment='產品描述')
    image_url = db.Column(db.String(500), comment='產品圖片')
    price = db.Column(db.Numeric(10, 2), nullable=False, comment='售價')
    cost = db.Column(db.Numeric(10, 2), default=0, comment='成本')
    is_active = db.Column(db.Boolean, default=True, comment='是否上架')
    is_featured = db.Column(db.Boolean, default=False, comment='是否為推薦商品')
    recorded_at = db.Column(db.DateTime, default=datetime.utcnow, comment='爬取日期')
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    store = db.relationship('Store', back_populates='products')
    tenant = db.relationship('Tenant')
    ingredients = db.relationship('ProductComposition', back_populates='product', cascade='all, delete-orphan', lazy='joined')

    def __repr__(self):
        return f'<Product {self.name}>'

    @property
    def profit_margin(self):
        if self.price and self.price > 0:
            return float((self.price - (self.cost or 0)) / self.price)
        return 0

    def calculate_cost(self):
        total_cost = Decimal('0')
        for pi in self.ingredients:
            if pi.ingredient and pi.ingredient.unit_cost:
                total_cost += pi.quantity * pi.ingredient.unit_cost
        self.cost = total_cost
        return total_cost

    def to_dict(self, include_ingredients=False):
        data = {
            'id': self.id,
            'tenant_id': self.tenant_id,
            'store_id': self.store_id,
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


class Ingredient(db.Model):
    """原物料 (ingredient)"""
    __tablename__ = 'ingredients'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    tenant_id = db.Column(db.Integer, db.ForeignKey('tenants.id'), nullable=False)
    store_id = db.Column(db.Integer, db.ForeignKey('stores.id'))
    name = db.Column(db.String(100), nullable=False, comment='原物料名稱')
    category = db.Column(db.String(50), comment='分類')
    unit = db.Column(db.String(20), comment='單位')
    unit_cost = db.Column(db.Numeric(10, 2), comment='單位成本')
    stock_quantity = db.Column(db.Numeric(10, 2), default=0, comment='庫存數量')
    low_stock_threshold = db.Column(db.Numeric(10, 2), comment='低庫存警示門檻')
    is_active = db.Column(db.Boolean, default=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    store = db.relationship('Store', back_populates='ingredients')
    tenant = db.relationship('Tenant')
    product_compositions = db.relationship('ProductComposition', back_populates='ingredient')
    price_history = db.relationship('PriceHistory', back_populates='ingredient', lazy='dynamic')

    def __repr__(self):
        return f'<Ingredient {self.name}>'

    @property
    def is_low_stock(self):
        if self.low_stock_threshold and self.stock_quantity:
            return self.stock_quantity <= self.low_stock_threshold
        return False

    def to_dict(self):
        return {
            'id': self.id,
            'tenant_id': self.tenant_id,
            'store_id': self.store_id,
            'name': self.name,
            'category': self.category,
            'unit': self.unit,
            'unit_cost': float(self.unit_cost) if self.unit_cost else None,
            'stock_quantity': float(self.stock_quantity) if self.stock_quantity else None,
            'is_low_stock': self.is_low_stock,
            'is_active': self.is_active,
            'created_at': self.created_at.isoformat() if self.created_at else None
        }


class ProductComposition(db.Model):
    """飲品組成 (product_composition) - 組長規格名稱"""
    __tablename__ = 'product_compositions'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    product_id = db.Column(db.Integer, db.ForeignKey('products.id'), nullable=False)
    ingredient_id = db.Column(db.Integer, db.ForeignKey('ingredients.id'), nullable=False)
    quantity = db.Column(db.Numeric(10, 4), nullable=False, default=1, comment='使用量')

    product = db.relationship('Product', back_populates='ingredients')
    ingredient = db.relationship('Ingredient', back_populates='product_compositions')

    __table_args__ = (
        db.UniqueConstraint('product_id', 'ingredient_id', name='uq_product_composition'),
    )

    def __repr__(self):
        return f'<ProductComposition {self.product_id} - {self.ingredient_id}>'

    @property
    def cost(self):
        if self.ingredient and self.ingredient.unit_cost:
            return float(self.quantity * self.ingredient.unit_cost)
        return 0

    def to_dict(self):
        return {
            'id': self.id,
            'product_id': self.product_id,
            'ingredient_id': self.ingredient_id,
            'ingredient_name': self.ingredient.name if self.ingredient else None,
            'ingredient_unit': self.ingredient.unit if self.ingredient else None,
            'quantity': float(self.quantity),
            'cost': self.cost
        }


# 相容舊程式碼的 alias
ProductIngredient = ProductComposition


class PriceHistory(db.Model):
    """價格追蹤 (price_history) - 組長新增"""
    __tablename__ = 'price_history'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    ingredient_id = db.Column(db.Integer, db.ForeignKey('ingredients.id'), nullable=False)
    market_price = db.Column(db.Numeric(10, 2), comment='當日市場價格')
    change_rate = db.Column(db.Numeric(5, 2), comment='漲跌百分比')
    recorded_at = db.Column(db.DateTime, default=datetime.utcnow)

    ingredient = db.relationship('Ingredient', back_populates='price_history')

    def to_dict(self):
        return {
            'id': self.id,
            'ingredient_id': self.ingredient_id,
            'market_price': float(self.market_price) if self.market_price else None,
            'change_rate': float(self.change_rate) if self.change_rate else None,
            'recorded_at': self.recorded_at.isoformat() if self.recorded_at else None
        }


# ==================== 外部素材與環境資料（組長新增）====================

class ExternalTrend(db.Model):
    """趨勢素材 (external_trends)"""
    __tablename__ = 'external_trends'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    source_type = db.Column(db.String(50), comment='素材來源 News/Google Trends')
    content_summary = db.Column(db.Text, comment='標題或關鍵字')
    recorded_at = db.Column(db.DateTime, default=datetime.utcnow)

    def to_dict(self):
        return {
            'id': self.id,
            'source_type': self.source_type,
            'content_summary': self.content_summary,
            'recorded_at': self.recorded_at.isoformat() if self.recorded_at else None
        }


class WeatherCache(db.Model):
    """天氣紀錄 (weather_cache)"""
    __tablename__ = 'weather_cache'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    city_name = db.Column(db.String(50), comment='城市名')
    condition = db.Column(db.String(50), comment='天氣狀況')
    temperature = db.Column(db.Integer, comment='氣溫')
    recorded_at = db.Column(db.DateTime, default=datetime.utcnow)

    def to_dict(self):
        return {
            'id': self.id,
            'city_name': self.city_name,
            'condition': self.condition,
            'temperature': self.temperature,
            'recorded_at': self.recorded_at.isoformat() if self.recorded_at else None
        }


class HolidayCalendar(db.Model):
    """節日曆 (holiday_calendar)"""
    __tablename__ = 'holiday_calendar'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    holiday_name = db.Column(db.String(100), comment='節日名稱')
    target_date = db.Column(db.Date, comment='節日日期')
    countdown_days = db.Column(db.Integer, comment='倒數天數')

    def to_dict(self):
        return {
            'id': self.id,
            'holiday_name': self.holiday_name,
            'target_date': self.target_date.isoformat() if self.target_date else None,
            'countdown_days': self.countdown_days
        }


# ==================== 歷史內容查詢 ====================

class MarketingContent(db.Model):
    """文案 (marketing_content)"""
    __tablename__ = 'marketing_contents'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    store_id = db.Column(db.Integer, db.ForeignKey('stores.id'), nullable=False)
    reviewed_by = db.Column(db.Integer, db.ForeignKey('users.id'), comment='審核者')
    product_id = db.Column(db.Integer, db.ForeignKey('products.id'), comment='關聯產品')
    ai_prompt = db.Column(db.Text, comment='使用的 AI Prompt')
    generated_text = db.Column(db.Text, nullable=False, comment='生成的文案')
    weather_context = db.Column(db.String(100), comment='天氣情境')
    trend_context = db.Column(db.String(255), comment='趨勢情境')
    final_text = db.Column(db.Text, comment='編輯後的最終文案')
    status = db.Column(db.String(20), nullable=False, default='draft', index=True)
    published_at = db.Column(db.DateTime, comment='發布時間')
    ig_post_id = db.Column(db.String(100), comment='Instagram 貼文 ID')
    ig_permalink = db.Column(db.String(500), comment='Instagram 貼文連結')
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    store = db.relationship('Store', back_populates='marketing_contents')
    reviewer = db.relationship('User', back_populates='reviewed_contents', foreign_keys=[reviewed_by])
    product = db.relationship('Product')
    images = db.relationship('ContentImage', back_populates='content', cascade='all, delete-orphan', lazy='joined')

    def __repr__(self):
        return f'<MarketingContent {self.id} - {self.status}>'

    @property
    def display_text(self):
        return self.final_text or self.generated_text

    @property
    def is_editable(self):
        return self.status in ('draft', 'pending', 'rejected')

    @property
    def is_publishable(self):
        return self.status == 'approved'

    def approve(self, reviewer_id):
        self.status = 'approved'
        self.reviewed_by = reviewer_id
        self.updated_at = datetime.utcnow()

    def reject(self, reviewer_id):
        self.status = 'rejected'
        self.reviewed_by = reviewer_id
        self.updated_at = datetime.utcnow()

    def mark_published(self, ig_post_id=None, ig_permalink=None):
        self.status = 'published'
        self.published_at = datetime.utcnow()
        if ig_post_id:
            self.ig_post_id = ig_post_id
        if ig_permalink:
            self.ig_permalink = ig_permalink

    def to_dict(self, include_images=True):
        data = {
            'id': self.id,
            'store_id': self.store_id,
            'product_id': self.product_id,
            'product_name': self.product.name if self.product else None,
            'generated_text': self.generated_text,
            'final_text': self.final_text,
            'display_text': self.display_text,
            'weather_context': self.weather_context,
            'trend_context': self.trend_context,
            'status': self.status,
            'reviewed_by': self.reviewed_by,
            'published_at': self.published_at.isoformat() if self.published_at else None,
            'ig_post_id': self.ig_post_id,
            'ig_permalink': self.ig_permalink,
            'created_at': self.created_at.isoformat() if self.created_at else None,
            'updated_at': self.updated_at.isoformat() if self.updated_at else None
        }
        if include_images:
            data['images'] = [img.to_dict() for img in self.images]
        return data


class ContentImage(db.Model):
    """圖片 (content_image)"""
    __tablename__ = 'content_images'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    content_id = db.Column(db.Integer, db.ForeignKey('marketing_contents.id'), nullable=False)
    image_url = db.Column(db.String(500), nullable=False, comment='圖片 URL')
    minio_url = db.Column(db.String(500), comment='MinIO 路徑')
    thumbnail_url = db.Column(db.String(500), comment='縮圖 URL')
    prompt_used = db.Column(db.Text, comment='AI 圖片 Prompt')
    model_used = db.Column(db.String(50), comment='AI 模型')
    width = db.Column(db.Integer, comment='寬度')
    height = db.Column(db.Integer, comment='高度')
    file_size = db.Column(db.Integer, comment='檔案大小')
    mime_type = db.Column(db.String(50), default='image/png')
    is_primary = db.Column(db.Boolean, default=False, comment='是否為主圖')
    sort_order = db.Column(db.Integer, default=0)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)

    content = db.relationship('MarketingContent', back_populates='images')

    def __repr__(self):
        return f'<ContentImage {self.id}>'

    def to_dict(self):
        return {
            'id': self.id,
            'content_id': self.content_id,
            'image_url': self.image_url,
            'minio_url': self.minio_url,
            'thumbnail_url': self.thumbnail_url,
            'prompt_used': self.prompt_used,
            'width': self.width,
            'height': self.height,
            'file_size': self.file_size,
            'is_primary': self.is_primary,
            'created_at': self.created_at.isoformat() if self.created_at else None
        }
