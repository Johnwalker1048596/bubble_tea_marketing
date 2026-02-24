"""手搖飲行銷助手 - Flask API Server"""
from flask import Flask, jsonify
from flask_cors import CORS
from flasgger import Swagger

from extensions import db, migrate, jwt, ma
from config import Config


def create_app(config_class=Config):
    app = Flask(__name__)
    app.config.from_object(config_class)

    # 初始化擴展
    db.init_app(app)
    migrate.init_app(app, db)
    jwt.init_app(app)
    ma.init_app(app)
    CORS(app)

    # Swagger/OpenAPI 設定
    swagger_config = {
        "headers": [],
        "specs": [{
            "endpoint": 'apispec',
            "route": '/apispec.json',
            "rule_filter": lambda rule: True,
            "model_filter": lambda tag: True,
        }],
        "static_url_path": "/flasgger_static",
        "swagger_ui": True,
        "specs_route": "/docs"
    }
    swagger_template = {
        "info": {
            "title": "手搖飲行銷助手 API",
            "description": "AI 驅動的手搖飲行銷內容生成系統",
            "version": "1.0.0",
            "contact": {"name": "AIPE02 第三組"}
        },
        "securityDefinitions": {
            "Bearer": {
                "type": "apiKey",
                "name": "Authorization",
                "in": "header",
                "description": "JWT Token: Bearer {token}"
            }
        },
        "security": [{"Bearer": []}]
    }
    Swagger(app, config=swagger_config, template=swagger_template)

    # 註冊藍圖
    from api.auth import auth_bp
    from api.products import products_bp
    from api.ingredients import ingredients_bp
    from api.content import content_bp
    from api.external import external_bp
    from api.settings import settings_bp

    app.register_blueprint(auth_bp, url_prefix='/api/v1/auth')
    app.register_blueprint(products_bp, url_prefix='/api/v1/products')
    app.register_blueprint(ingredients_bp, url_prefix='/api/v1/ingredients')
    app.register_blueprint(content_bp, url_prefix='/api/v1/content')
    app.register_blueprint(external_bp, url_prefix='/api/v1')
    app.register_blueprint(settings_bp, url_prefix='/api/v1/settings')

    # 健康檢查
    @app.route('/health')
    def health():
        """健康檢查
        ---
        tags:
          - System
        responses:
          200:
            description: 服務正常運作
        """
        return jsonify({'status': 'healthy', 'service': 'bubble-tea-marketing-api', 'version': '1.0.0'})

    # 根路由
    @app.route('/')
    def index():
        return jsonify({'message': '手搖飲行銷助手 API', 'docs': '/docs', 'health': '/health'})

    with app.app_context():
        db.create_all()

    return app


app = create_app()

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
