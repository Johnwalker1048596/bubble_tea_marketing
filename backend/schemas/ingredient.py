"""原物料 Schema"""
from marshmallow import Schema, fields


class IngredientSchema(Schema):
    id = fields.UUID(dump_only=True)
    store_id = fields.UUID(dump_only=True)
    name = fields.String(required=True)
    category = fields.String()
    unit = fields.String(required=True)
    unit_cost = fields.Decimal(as_string=True, required=True)
    stock_quantity = fields.Decimal(as_string=True)
    is_low_stock = fields.Boolean()
    is_active = fields.Boolean()
    created_at = fields.DateTime()
