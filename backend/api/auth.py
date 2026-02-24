"""認證 API"""
from flask import Blueprint, request, jsonify
from flask_jwt_extended import create_access_token, jwt_required, get_jwt_identity
from marshmallow import ValidationError

from extensions import db
from models import User, Store, Tenant
from schemas.auth import LoginSchema, RegisterSchema
from schemas.user import UserSchema

auth_bp = Blueprint('auth', __name__)
login_schema = LoginSchema()
register_schema = RegisterSchema()
user_schema = UserSchema()


@auth_bp.route('/login', methods=['POST'])
def login():
    """使用者登入"""
    try:
        data = login_schema.load(request.json)
    except ValidationError as e:
        return jsonify({'error': {'code': 'validation_error', 'details': e.messages}}), 422

    user = User.query.filter_by(email=data['email']).first()

    if not user or not user.check_password(data['password']):
        return jsonify({'error': {'code': 'auth_failed', 'message': '帳號或密碼錯誤'}}), 401

    if not user.is_active:
        return jsonify({'error': {'code': 'auth_failed', 'message': '帳號已被停用'}}), 401

    user.update_last_login()
    access_token = create_access_token(identity=str(user.id))

    return jsonify({
        'access_token': access_token,
        'token_type': 'bearer',
        'expires_in': 86400,
        'user': user_schema.dump(user)
    })


@auth_bp.route('/register', methods=['POST'])
def register():
    """使用者註冊（含建立店家）"""
    try:
        data = register_schema.load(request.json)
    except ValidationError as e:
        return jsonify({'error': {'code': 'validation_error', 'details': e.messages}}), 422

    if User.query.filter_by(email=data['email']).first():
        return jsonify({'error': {'code': 'validation_error', 'message': 'Email 已被註冊'}}), 400

    try:
        store_name = data['store_name']
        
        # 檢查是否已有同名品牌（已匯入的菜單資料）
        existing_tenant = Tenant.query.filter_by(name=store_name).first()
        
        if existing_tenant:
            # 使用已存在的品牌
            tenant = existing_tenant
            # 找該品牌的第一個店
            store = Store.query.filter_by(tenant_id=tenant.id).first()
            if not store:
                store = Store(tenant_id=tenant.id, name=f"{store_name} 總店")
                db.session.add(store)
                db.session.flush()
        else:
            # 建立新品牌
            tenant = Tenant(name=store_name)
            db.session.add(tenant)
            db.session.flush()

            store = Store(tenant_id=tenant.id, name=store_name)
            db.session.add(store)
            db.session.flush()

        user = User(
            store_id=store.id,
            email=data['email'],
            name=data.get('name'),
            role='owner'
        )
        user.set_password(data['password'])
        db.session.add(user)
        db.session.commit()

        return jsonify({
            'message': '註冊成功',
            'user': user_schema.dump(user),
            'is_existing_brand': existing_tenant is not None
        }), 201

    except Exception as e:
        db.session.rollback()
        return jsonify({'error': {'code': 'internal_error', 'message': str(e)}}), 500


@auth_bp.route('/brands', methods=['GET'])
def list_brands():
    """取得已有品牌列表（有菜單資料的）"""
    from sqlalchemy import func
    
    brands = db.session.query(
        Tenant.id,
        Tenant.name,
        func.count(db.text('products.id')).label('product_count')
    ).outerjoin(
        db.text('products'), db.text('products.tenant_id = tenants.id')
    ).group_by(Tenant.id).having(
        func.count(db.text('products.id')) > 0
    ).all()
    
    return jsonify([{
        'id': b.id,
        'name': b.name,
        'product_count': b.product_count
    } for b in brands])


@auth_bp.route('/me', methods=['GET'])
@jwt_required()
def get_current_user():
    """取得目前登入使用者資訊"""
    user_id = get_jwt_identity()
    user = User.query.get(user_id)

    if not user:
        return jsonify({'error': {'code': 'resource_not_found', 'message': '使用者不存在'}}), 404

    return jsonify(user_schema.dump(user))
