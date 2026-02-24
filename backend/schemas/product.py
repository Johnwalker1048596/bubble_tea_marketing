"""產品 Schema"""
from marshmallow import Schema, fields


class ProductIngredientSchema(Schema):
    id = fields.UUID()
    ingredient_id = fields.UUID()
    ingredient_name = fields.Method('get_ingredient_name')
    ingredient_unit = fields.Method('get_ingredient_unit')
    quantity = fields.Decimal(as_string=True)
    cost = fields.Method('get_cost')
    
    def get_ingredient_name(self, obj):
        return obj.ingredient.name if obj.ingredient else None
    
    def get_ingredient_unit(self, obj):
        return obj.ingredient.unit if obj.ingredient else None
    
    def get_cost(self, obj):
        return float(obj.cost) if obj.cost else 0


class ProductSchema(Schema):
    id = fields.UUID(dump_only=True)
    store_id = fields.UUID(dump_only=True)
    name = fields.String(required=True)
    category = fields.String()
    description = fields.String()
    image_url = fields.String()
    price = fields.Decimal(as_string=True, required=True)
    cost = fields.Decimal(as_string=True)
    profit_margin = fields.Float()
    is_active = fields.Boolean()
    is_featured = fields.Boolean()
    created_at = fields.DateTime()
    ingredients = fields.Nested(ProductIngredientSchema, many=True)


class ProductCreateSchema(Schema):
    name = fields.String(required=True)
    category = fields.String()
    description = fields.String()
    price = fields.Decimal(as_string=True, required=True)
    ingredients = fields.List(fields.Dict())
