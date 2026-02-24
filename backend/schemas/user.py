"""使用者 Schema"""
from marshmallow import Schema, fields


class UserSchema(Schema):
    id = fields.UUID(dump_only=True)
    store_id = fields.UUID(dump_only=True)
    email = fields.Email()
    name = fields.String()
    role = fields.String()
    is_active = fields.Boolean()
    last_login_at = fields.DateTime()
    created_at = fields.DateTime()
    
    # 關聯
    store_name = fields.Method('get_store_name')
    
    def get_store_name(self, obj):
        return obj.store.name if obj.store else None
