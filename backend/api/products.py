"""產品管理 API"""
from flask import Blueprint, request, jsonify
from flask_jwt_extended import jwt_required, get_jwt_identity

from extensions import db
from models import User, Product, ProductIngredient
from schemas.product import ProductSchema

products_bp = Blueprint('products', __name__)
product_schema = ProductSchema()
products_schema = ProductSchema(many=True)


def get_current_store_id():
    user_id = get_jwt_identity()
    user = User.query.get(user_id)
    return user.store_id if user else None


@products_bp.route('', methods=['GET'])
@jwt_required()
def list_products():
    """
    取得產品列表
    ---
    tags:
      - Products
    security:
      - Bearer: []
    parameters:
      - name: category
        in: query
        type: string
        description: 分類篩選
      - name: sortby
        in: query
        type: string
        enum: [name, price, cost]
        default: name
    responses:
      200:
        description: 產品列表
    """
    store_id = get_current_store_id()
    
    sort_by = request.args.get('sortby', 'name')
    order = request.args.get('order', 'asc')
    category = request.args.get('category')
    
    query = Product.query.filter_by(store_id=store_id, is_active=True)
    
    if category:
        query = query.filter_by(category=category)
    
    sort_column = getattr(Product, sort_by, Product.name)
    if order == 'desc':
        query = query.order_by(sort_column.desc())
    else:
        query = query.order_by(sort_column.asc())
    
    products = query.all()
    return jsonify({'data': products_schema.dump(products)})


@products_bp.route('', methods=['POST'])
@jwt_required()
def create_product():
    """
    建立產品
    ---
    tags:
      - Products
    security:
      - Bearer: []
    parameters:
      - in: body
        name: body
        schema:
          type: object
          required:
            - name
            - price
          properties:
            name:
              type: string
            category:
              type: string
            price:
              type: number
    responses:
      201:
        description: 建立成功
    """
    store_id = get_current_store_id()
    data = request.json
    
    product = Product(
        store_id=store_id,
        name=data['name'],
        category=data.get('category'),
        description=data.get('description'),
        price=data['price']
    )
    db.session.add(product)
    
    if 'ingredients' in data:
        for ing_data in data['ingredients']:
            pi = ProductIngredient(
                product_id=product.id,
                ingredient_id=ing_data['ingredient_id'],
                quantity=ing_data['quantity']
            )
            db.session.add(pi)
    
    db.session.commit()
    return jsonify({'product': product_schema.dump(product)}), 201


@products_bp.route('/<product_id>', methods=['GET'])
@jwt_required()
def get_product(product_id):
    """
    取得產品詳情
    ---
    tags:
      - Products
    security:
      - Bearer: []
    parameters:
      - name: product_id
        in: path
        type: string
        required: true
    responses:
      200:
        description: 產品詳情
      404:
        description: 產品不存在
    """
    store_id = get_current_store_id()
    product = Product.query.filter_by(id=product_id, store_id=store_id).first()
    
    if not product:
        return jsonify({'error': {'code': 'resource_not_found', 'message': '產品不存在'}}), 404
    
    return jsonify({'product': product_schema.dump(product)})


@products_bp.route('/<product_id>', methods=['PUT'])
@jwt_required()
def update_product(product_id):
    """
    更新產品
    ---
    tags:
      - Products
    security:
      - Bearer: []
    responses:
      200:
        description: 更新成功
    """
    store_id = get_current_store_id()
    product = Product.query.filter_by(id=product_id, store_id=store_id).first()
    
    if not product:
        return jsonify({'error': {'code': 'resource_not_found', 'message': '產品不存在'}}), 404
    
    data = request.json
    for field in ['name', 'category', 'description', 'price', 'is_active', 'is_featured']:
        if field in data:
            setattr(product, field, data[field])
    
    db.session.commit()
    return jsonify({'product': product_schema.dump(product)})


@products_bp.route('/<product_id>', methods=['DELETE'])
@jwt_required()
def delete_product(product_id):
    """
    刪除產品
    ---
    tags:
      - Products
    security:
      - Bearer: []
    responses:
      204:
        description: 刪除成功
    """
    store_id = get_current_store_id()
    product = Product.query.filter_by(id=product_id, store_id=store_id).first()
    
    if not product:
        return jsonify({'error': {'code': 'resource_not_found', 'message': '產品不存在'}}), 404
    
    product.is_active = False
    db.session.commit()
    return '', 204


@products_bp.route('/low-cost', methods=['GET'])
@jwt_required()
def get_low_cost_products():
    """
    取得低成本高毛利推薦產品
    ---
    tags:
      - Products
    security:
      - Bearer: []
    parameters:
      - name: limit
        in: query
        type: integer
        default: 5
    responses:
      200:
        description: 推薦產品列表
    """
    store_id = get_current_store_id()
    limit = request.args.get('limit', 5, type=int)
    
    products = Product.query.filter_by(
        store_id=store_id,
        is_active=True
    ).order_by(
        ((Product.price - Product.cost) / Product.price).desc()
    ).limit(limit).all()
    
    recommendations = []
    for product in products:
        recommendations.append({
            'id': str(product.id),
            'name': product.name,
            'cost': float(product.cost) if product.cost else 0,
            'price': float(product.price),
            'profit_margin': product.profit_margin,
            'reason': f'毛利率 {int(product.profit_margin * 100)}%'
        })
    
    return jsonify({'recommendations': recommendations})
