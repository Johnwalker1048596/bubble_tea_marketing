"""
行銷內容 API
整合 AI 生成、RAG、天氣、趨勢服務
"""
from flask import Blueprint, request, jsonify
from flask_jwt_extended import jwt_required, get_jwt_identity
from datetime import datetime

from extensions import db
from models import User, MarketingContent, Product
from services.ai_service import AIService
from services.weather_service import WeatherService
from services.news_service import NewsService
from services.rag_service import RAGService

content_bp = Blueprint('content', __name__)

# 初始化服務
ai_service = AIService()
weather_service = WeatherService()
news_service = NewsService()
rag_service = RAGService()


def get_current_store_id():
    """取得當前使用者的店家 ID"""
    user_id = get_jwt_identity()
    user = User.query.get(user_id)
    return user.store_id if user else None


@content_bp.route('/generate', methods=['POST'])
@jwt_required()
def generate_content():
    """
    AI 生成行銷內容
    ---
    tags:
      - Content
    security:
      - Bearer: []
    parameters:
      - in: body
        name: body
        schema:
          type: object
          properties:
            product_id:
              type: string
              description: 產品 ID（可選）
            include_weather:
              type: boolean
              default: true
              description: 是否加入天氣情境
            include_trend:
              type: boolean
              default: true
              description: 是否加入熱門趨勢
            custom_prompt:
              type: string
              description: 額外要求
    responses:
      200:
        description: 生成成功
    """
    store_id = get_current_store_id()
    data = request.json or {}
    
    # 1. 取得產品資訊
    product_data = None
    product = None
    if data.get('product_id'):
        product = Product.query.filter_by(
            id=data['product_id'],
            store_id=store_id
        ).first()
        if product:
            product_data = {
                'name': product.name,
                'description': product.description,
                'category': product.category,
                'price': float(product.price) if product.price else None
            }
    
    # 2. 取得天氣資訊
    weather_context = None
    weather_data = None
    if data.get('include_weather', True):
        weather_data = weather_service.get_weather()
        weather_context = weather_data.get('description', '')
    
    # 3. 取得熱門趨勢
    trend_context = None
    if data.get('include_trend', True):
        trends = news_service.get_trending_topics()
        trend_context = '、'.join(trends.get('topics', []))
    
    # 4. 取得 RAG 上下文
    rag_context = rag_service.get_context_for_generation(
        product_name=product_data['name'] if product_data else None,
        category=product_data.get('category') if product_data else None,
        weather=weather_data.get('recommendation') if weather_data else None
    )
    
    # 5. AI 生成文案
    generated_text = ai_service.generate_content(
        product=product_data,
        weather=weather_context,
        trend=trend_context,
        rag_context=rag_context,
        custom_prompt=data.get('custom_prompt')
    )
    
    # 6. 儲存到資料庫
    content = MarketingContent(
        store_id=store_id,
        product_id=product.id if product else None,
        generated_text=generated_text,
        weather_context=weather_context,
        trend_context=trend_context,
        status='draft'
    )
    db.session.add(content)
    db.session.commit()
    
    # 7. 同步產品到 RAG（如果有新產品）
    if product and product_data:
        rag_service.add_product(
            product_id=str(product.id),
            name=product_data['name'],
            description=product_data.get('description', ''),
            category=product_data.get('category', ''),
            price=product_data.get('price')
        )
    
    return jsonify({
        'content': {
            'id': str(content.id),
            'generated_text': generated_text,
            'weather_context': weather_context,
            'trend_context': trend_context,
            'product_name': product.name if product else None,
            'status': 'draft',
            'created_at': content.created_at.isoformat()
        },
        'metadata': {
            'weather': weather_data,
            'trends': news_service.get_trending_topics() if data.get('include_trend', True) else None,
            'used_rag': bool(rag_context)
        }
    })


@content_bp.route('', methods=['GET'])
@jwt_required()
def list_contents():
    """取得內容列表"""
    store_id = get_current_store_id()
    
    page = request.args.get('page', 1, type=int)
    limit = request.args.get('limit', 10, type=int)
    status = request.args.get('status')
    
    query = MarketingContent.query.filter_by(store_id=store_id)
    
    if status and status != 'all':
        query = query.filter_by(status=status)
    
    query = query.order_by(MarketingContent.created_at.desc())
    pagination = query.paginate(page=page, per_page=limit, error_out=False)
    
    result = []
    for content in pagination.items:
        result.append({
            'id': str(content.id),
            'generated_text': content.generated_text,
            'weather_context': content.weather_context,
            'trend_context': content.trend_context,
            'product_name': content.product.name if content.product else None,
            'status': content.status,
            'is_edited': content.is_edited,
            'created_at': content.created_at.isoformat(),
            'published_at': content.published_at.isoformat() if content.published_at else None
        })
    
    return jsonify({
        'data': result,
        'pagination': {
            'page': page,
            'limit': limit,
            'total': pagination.total,
            'total_pages': pagination.pages
        }
    })


@content_bp.route('/<content_id>', methods=['GET'])
@jwt_required()
def get_content(content_id):
    """取得單一內容詳情"""
    store_id = get_current_store_id()
    content = MarketingContent.query.filter_by(
        id=content_id,
        store_id=store_id
    ).first()
    
    if not content:
        return jsonify({'error': {'code': 'not_found', 'message': '內容不存在'}}), 404
    
    return jsonify({
        'content': {
            'id': str(content.id),
            'generated_text': content.generated_text,
            'weather_context': content.weather_context,
            'trend_context': content.trend_context,
            'product': {
                'id': str(content.product.id),
                'name': content.product.name
            } if content.product else None,
            'status': content.status,
            'is_edited': content.is_edited,
            'created_at': content.created_at.isoformat(),
            'updated_at': content.updated_at.isoformat() if content.updated_at else None,
            'published_at': content.published_at.isoformat() if content.published_at else None
        }
    })


@content_bp.route('/<content_id>', methods=['PUT'])
@jwt_required()
def update_content(content_id):
    """更新內容"""
    store_id = get_current_store_id()
    content = MarketingContent.query.filter_by(
        id=content_id,
        store_id=store_id
    ).first()
    
    if not content:
        return jsonify({'error': {'code': 'not_found', 'message': '內容不存在'}}), 404
    
    data = request.json
    
    if 'generated_text' in data:
        content.generated_text = data['generated_text']
        content.is_edited = True
    
    if 'status' in data:
        content.status = data['status']
        if data['status'] == 'published':
            content.published_at = datetime.utcnow()
    
    content.updated_at = datetime.utcnow()
    db.session.commit()
    
    return jsonify({
        'content': {
            'id': str(content.id),
            'generated_text': content.generated_text,
            'status': content.status,
            'is_edited': content.is_edited,
            'updated_at': content.updated_at.isoformat()
        }
    })


@content_bp.route('/<content_id>', methods=['DELETE'])
@jwt_required()
def delete_content(content_id):
    """刪除內容"""
    store_id = get_current_store_id()
    content = MarketingContent.query.filter_by(
        id=content_id,
        store_id=store_id
    ).first()
    
    if not content:
        return jsonify({'error': {'code': 'not_found', 'message': '內容不存在'}}), 404
    
    db.session.delete(content)
    db.session.commit()
    
    return '', 204


@content_bp.route('/<content_id>/publish', methods=['POST'])
@jwt_required()
def publish_content(content_id):
    """發布到 Instagram（模擬）"""
    store_id = get_current_store_id()
    content = MarketingContent.query.filter_by(
        id=content_id,
        store_id=store_id
    ).first()
    
    if not content:
        return jsonify({'error': {'code': 'not_found', 'message': '內容不存在'}}), 404
    
    # TODO: 實際串接 Instagram Graph API
    content.status = 'published'
    content.published_at = datetime.utcnow()
    db.session.commit()
    
    return jsonify({
        'message': '發布成功',
        'content': {
            'id': str(content.id),
            'status': 'published',
            'published_at': content.published_at.isoformat()
        },
        'instagram': {
            'post_id': f'mock_ig_{content.id}',
            'permalink': f'https://instagram.com/p/mock_{content.id}'
        },
        'note': '目前為模擬發布，實際 Instagram API 串接需要 Meta Business 帳號授權'
    })


@content_bp.route('/<content_id>/regenerate', methods=['POST'])
@jwt_required()
def regenerate_content(content_id):
    """重新生成內容"""
    store_id = get_current_store_id()
    content = MarketingContent.query.filter_by(
        id=content_id,
        store_id=store_id
    ).first()
    
    if not content:
        return jsonify({'error': {'code': 'not_found', 'message': '內容不存在'}}), 404
    
    data = request.json or {}
    
    # 取得產品資訊
    product_data = None
    if content.product:
        product_data = {
            'name': content.product.name,
            'description': content.product.description,
            'category': content.product.category,
            'price': float(content.product.price) if content.product.price else None
        }
    
    # 重新生成
    weather_data = weather_service.get_weather() if data.get('include_weather', True) else None
    trends = news_service.get_trending_topics() if data.get('include_trend', True) else None
    
    generated_text = ai_service.generate_content(
        product=product_data,
        weather=weather_data.get('description') if weather_data else None,
        trend='、'.join(trends.get('topics', [])) if trends else None,
        custom_prompt=data.get('custom_prompt')
    )
    
    content.generated_text = generated_text
    content.weather_context = weather_data.get('description') if weather_data else None
    content.trend_context = '、'.join(trends.get('topics', [])) if trends else None
    content.is_edited = False
    content.updated_at = datetime.utcnow()
    db.session.commit()
    
    return jsonify({
        'content': {
            'id': str(content.id),
            'generated_text': generated_text,
            'weather_context': content.weather_context,
            'trend_context': content.trend_context,
            'status': content.status
        }
    })
