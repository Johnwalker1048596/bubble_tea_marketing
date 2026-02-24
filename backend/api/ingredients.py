"""原物料管理 API"""
from flask import Blueprint, request, jsonify
from flask_jwt_extended import jwt_required, get_jwt_identity

from extensions import db
from models import User, Ingredient
from schemas.ingredient import IngredientSchema

ingredients_bp = Blueprint('ingredients', __name__)
ingredient_schema = IngredientSchema()
ingredients_schema = IngredientSchema(many=True)


def get_current_store_id():
    user_id = get_jwt_identity()
    user = User.query.get(user_id)
    return user.store_id if user else None


@ingredients_bp.route('', methods=['GET'])
@jwt_required()
def list_ingredients():
    """
    取得原物料列表
    ---
    tags:
      - Ingredients
    security:
      - Bearer: []
    responses:
      200:
        description: 原物料列表
    """
    store_id = get_current_store_id()
    ingredients = Ingredient.query.filter_by(store_id=store_id, is_active=True).all()
    return jsonify({'data': ingredients_schema.dump(ingredients)})


@ingredients_bp.route('', methods=['POST'])
@jwt_required()
def create_ingredient():
    """
    建立原物料
    ---
    tags:
      - Ingredients
    security:
      - Bearer: []
    parameters:
      - in: body
        name: body
        schema:
          type: object
          required:
            - name
            - unit
            - unit_cost
          properties:
            name:
              type: string
            unit:
              type: string
            unit_cost:
              type: number
    responses:
      201:
        description: 建立成功
    """
    store_id = get_current_store_id()
    data = request.json
    
    ingredient = Ingredient(
        store_id=store_id,
        name=data['name'],
        unit=data['unit'],
        unit_cost=data['unit_cost'],
        category=data.get('category')
    )
    db.session.add(ingredient)
    db.session.commit()
    
    return jsonify({'ingredient': ingredient_schema.dump(ingredient)}), 201


@ingredients_bp.route('/<ingredient_id>', methods=['PUT'])
@jwt_required()
def update_ingredient(ingredient_id):
    """
    更新原物料
    ---
    tags:
      - Ingredients
    security:
      - Bearer: []
    responses:
      200:
        description: 更新成功
    """
    store_id = get_current_store_id()
    ingredient = Ingredient.query.filter_by(id=ingredient_id, store_id=store_id).first()
    
    if not ingredient:
        return jsonify({'error': {'code': 'resource_not_found', 'message': '原物料不存在'}}), 404
    
    data = request.json
    for field in ['name', 'unit', 'unit_cost', 'category']:
        if field in data:
            setattr(ingredient, field, data[field])
    
    db.session.commit()
    return jsonify({'ingredient': ingredient_schema.dump(ingredient)})


@ingredients_bp.route('/<ingredient_id>', methods=['DELETE'])
@jwt_required()
def delete_ingredient(ingredient_id):
    """
    刪除原物料
    ---
    tags:
      - Ingredients
    security:
      - Bearer: []
    responses:
      204:
        description: 刪除成功
    """
    store_id = get_current_store_id()
    ingredient = Ingredient.query.filter_by(id=ingredient_id, store_id=store_id).first()
    
    if not ingredient:
        return jsonify({'error': {'code': 'resource_not_found', 'message': '原物料不存在'}}), 404
    
    ingredient.is_active = False
    db.session.commit()
    return '', 204
