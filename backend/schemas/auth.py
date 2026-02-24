"""認證相關 Schema"""
from marshmallow import Schema, fields, validate


class LoginSchema(Schema):
    email = fields.Email(required=True)
    password = fields.String(required=True, validate=validate.Length(min=6))


class RegisterSchema(Schema):
    email = fields.Email(required=True)
    password = fields.String(required=True, validate=validate.Length(min=6))
    name = fields.String()
    store_name = fields.String(required=True, validate=validate.Length(min=1, max=100))
    tenant_name = fields.String()
