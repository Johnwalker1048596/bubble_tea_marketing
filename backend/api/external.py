"""外部 API - 天氣、趨勢"""
from flask import Blueprint, request, jsonify
from flask_jwt_extended import jwt_required

from services.weather_service import WeatherService
from services.news_service import NewsService
from services.rag_service import RAGService

external_bp = Blueprint('external', __name__)
weather_service = WeatherService()
news_service = NewsService()
rag_service = RAGService()


@external_bp.route('/weather', methods=['GET'])
@jwt_required()
def get_weather():
    """
    取得天氣資訊
    ---
    tags:
      - External
    security:
      - Bearer: []
    parameters:
      - in: query
        name: city
        type: string
        default: taipei
        description: 城市代碼 (taipei/taichung/kaohsiung/tainan/hsinchu)
    responses:
      200:
        description: 天氣資訊
    """
    city = request.args.get('city', 'taipei')
    weather = weather_service.get_weather(city)
    return jsonify(weather)


@external_bp.route('/trends', methods=['GET'])
@jwt_required()
def get_trends():
    """
    取得熱門趨勢
    ---
    tags:
      - External
    security:
      - Bearer: []
    responses:
      200:
        description: 熱門趨勢
    """
    trends = news_service.get_trending_topics()
    news = news_service.get_drink_news()
    
    return jsonify({
        'trends': trends,
        'news': news
    })


@external_bp.route('/rag/search', methods=['POST'])
@jwt_required()
def rag_search():
    """
    RAG 搜尋相似產品
    ---
    tags:
      - External
    security:
      - Bearer: []
    parameters:
      - in: body
        name: body
        schema:
          type: object
          properties:
            query:
              type: string
            limit:
              type: integer
              default: 5
    responses:
      200:
        description: 搜尋結果
    """
    data = request.json or {}
    query = data.get('query', '')
    limit = data.get('limit', 5)
    
    results = rag_service.search_similar(query, n_results=limit)
    
    return jsonify({
        'query': query,
        'results': results
    })


@external_bp.route('/rag/rebuild', methods=['POST'])
@jwt_required()
def rag_rebuild():
    """
    重建 RAG 索引
    ---
    tags:
      - External
    security:
      - Bearer: []
    responses:
      200:
        description: 重建結果
    """
    from models import Product
    from flask_jwt_extended import get_jwt_identity
    from models import User
    
    user_id = get_jwt_identity()
    user = User.query.get(user_id)
    
    if not user:
        return jsonify({'error': 'Unauthorized'}), 401
    
    # 取得該店家所有產品
    products = Product.query.filter_by(store_id=user.store_id, is_active=True).all()
    
    product_list = [{
        'id': str(p.id),
        'name': p.name,
        'description': p.description,
        'category': p.category,
        'price': float(p.price) if p.price else None
    } for p in products]
    
    count = rag_service.rebuild_index(product_list)
    
    return jsonify({
        'message': f'成功重建 {count} 個產品的索引',
        'total_products': len(product_list),
        'indexed': count
    })
