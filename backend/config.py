import os
from datetime import timedelta
from dotenv import load_dotenv

load_dotenv()

class Config:
    """應用程式配置"""
    
    # Flask
    SECRET_KEY = os.getenv('JWT_SECRET', 'dev-secret-key')
    
    # Database
    SQLALCHEMY_DATABASE_URI = os.getenv(
        'DATABASE_URL',
        'postgresql://postgres:postgres@localhost:5432/bubble_tea'
    )
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    SQLALCHEMY_ENGINE_OPTIONS = {
        'pool_pre_ping': True,
        'pool_recycle': 300,
    }
    
    # JWT
    JWT_SECRET_KEY = os.getenv('JWT_SECRET', 'dev-secret-key')
    JWT_ACCESS_TOKEN_EXPIRES = timedelta(hours=24)
    
    # MinIO
    MINIO_ENDPOINT = os.getenv('MINIO_ENDPOINT', 'localhost:9000')
    MINIO_ACCESS_KEY = os.getenv('MINIO_ACCESS_KEY', 'minioadmin')
    MINIO_SECRET_KEY = os.getenv('MINIO_SECRET_KEY', 'minioadmin')
    MINIO_BUCKET = os.getenv('MINIO_BUCKET', 'marketing-images')
    MINIO_SECURE = os.getenv('MINIO_SECURE', 'false').lower() == 'true'
    
    # External APIs
    NANOBANANA_API_KEY = os.getenv('NANOBANANA_API_KEY', '')
    NANOBANANA_API_URL = os.getenv('NANOBANANA_API_URL', 'https://api.nanobanana.com/v1')
    WEATHER_API_KEY = os.getenv('WEATHER_API_KEY', '')
    WEATHER_API_URL = os.getenv('WEATHER_API_URL', 'https://api.openweathermap.org/data/2.5')
    
    # Instagram
    IG_CLIENT_ID = os.getenv('IG_CLIENT_ID', '')
    IG_CLIENT_SECRET = os.getenv('IG_CLIENT_SECRET', '')
    IG_REDIRECT_URI = os.getenv('IG_REDIRECT_URI', 'http://localhost:3000/callback/instagram')


class DevelopmentConfig(Config):
    DEBUG = True


class ProductionConfig(Config):
    DEBUG = False


class TestingConfig(Config):
    TESTING = True
    SQLALCHEMY_DATABASE_URI = 'sqlite:///:memory:'


config = {
    'development': DevelopmentConfig,
    'production': ProductionConfig,
    'testing': TestingConfig,
    'default': DevelopmentConfig
}
