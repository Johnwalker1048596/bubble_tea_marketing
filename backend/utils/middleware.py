"""多租戶中間件 - 確保資料隔離"""
from functools import wraps
from flask import g, jsonify
from flask_jwt_extended import get_jwt_identity, verify_jwt_in_request
from models import User


class TenantMiddleware:
    """多租戶中間件類別"""
    
    def __init__(self, app=None):
        if app:
            self.init_app(app)
    
    def init_app(self, app):
        app.before_request(self._load_tenant_context)
    
    def _load_tenant_context(self):
        """每次請求前載入租戶上下文"""
        try:
            verify_jwt_in_request(optional=True)
            user_id = get_jwt_identity()
            if user_id:
                user = User.query.get(user_id)
                if user:
                    g.current_user = user
                    g.store_id = user.store_id
                    g.tenant_id = user.store.tenant_id if user.store else None
        except:
            pass


def tenant_required(f):
    """裝飾器：確保請求只能存取自己店家的資料"""
    @wraps(f)
    def decorated(*args, **kwargs):
        if not hasattr(g, 'store_id') or not g.store_id:
            return jsonify({'error': {'code': 'tenant_required', 'message': '需要店家授權'}}), 403
        return f(*args, **kwargs)
    return decorated


def owner_required(f):
    """裝飾器：只有 owner 可以執行"""
    @wraps(f)
    def decorated(*args, **kwargs):
        if not hasattr(g, 'current_user') or g.current_user.role != 'owner':
            return jsonify({'error': {'code': 'permission_denied', 'message': '需要擁有者權限'}}), 403
        return f(*args, **kwargs)
    return decorated


def manager_required(f):
    """裝飾器：owner 或 manager 可以執行"""
    @wraps(f)
    def decorated(*args, **kwargs):
        if not hasattr(g, 'current_user') or g.current_user.role not in ('owner', 'manager'):
            return jsonify({'error': {'code': 'permission_denied', 'message': '需要管理者權限'}}), 403
        return f(*args, **kwargs)
    return decorated


def get_current_user():
    """取得目前使用者"""
    return getattr(g, 'current_user', None)


def get_current_store_id():
    """取得目前使用者的 store_id"""
    return getattr(g, 'store_id', None)


def get_current_tenant_id():
    """取得目前使用者的 tenant_id"""
    return getattr(g, 'tenant_id', None)
