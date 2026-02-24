"""內容 Schema"""
from marshmallow import Schema, fields


class ContentImageSchema(Schema):
    id = fields.UUID()
    image_url = fields.String()
    thumbnail_url = fields.String()
    prompt_used = fields.String()
    is_primary = fields.Boolean()
    created_at = fields.DateTime()


class ContentSchema(Schema):
    id = fields.UUID(dump_only=True)
    store_id = fields.UUID(dump_only=True)
    product_id = fields.UUID()
    product_name = fields.Method('get_product_name')
    generated_text = fields.String()
    final_text = fields.String()
    display_text = fields.Method('get_display_text')
    weather_context = fields.String()
    trend_context = fields.String()
    status = fields.String()
    reviewed_by = fields.UUID()
    published_at = fields.DateTime()
    ig_post_id = fields.String()
    ig_permalink = fields.String()
    created_at = fields.DateTime()
    updated_at = fields.DateTime()
    images = fields.Nested(ContentImageSchema, many=True)
    
    def get_product_name(self, obj):
        return obj.product.name if obj.product else None
    
    def get_display_text(self, obj):
        return obj.final_text or obj.generated_text


class ContentCreateSchema(Schema):
    product_id = fields.UUID()
    include_weather = fields.Boolean(load_default=True)
    include_trend = fields.Boolean(load_default=True)
    custom_prompt = fields.String()
