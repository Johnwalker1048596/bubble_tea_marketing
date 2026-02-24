"""設定管理 API"""
from flask import Blueprint, request, jsonify
from flask_jwt_extended import jwt_required, get_jwt_identity

from extensions import db
from models import User, Store
from utils.instagram_client import InstagramClient

settings_bp = Blueprint('settings', __name__)


def get_current_user_and_store():
    user_id = get_jwt_identity()
    user = User.query.get(user_id)
    store = Store.query.get(user.store_id) if user else None
    return user, store


@settings_bp.route('/store', methods=['GET'])
@jwt_required()
def get_store_settings():
    """
    取得店家設定
    ---
    GET /api/v1/settings/store
    """
    user, store = get_current_user_and_store()
    
    if not store:
        return jsonify({'error': {'code': 'resource_not_found', 'message': '店家不存在'}}), 404
    
    return jsonify(store.to_dict())


@settings_bp.route('/store', methods=['PUT'])
@jwt_required()
def update_store_settings():
    """
    更新店家設定
    ---
    PUT /api/v1/settings/store
    """
    user, store = get_current_user_and_store()
    
    if not user.is_owner:
        return jsonify({'error': {'code': 'permission_denied', 'message': '只有擁有者可以修改店家設定'}}), 403
    
    data = request.json
    
    for field in ['name', 'description', 'address', 'phone']:
        if field in data:
            setattr(store, field, data[field])
    
    db.session.commit()
    
    return jsonify(store.to_dict())


@settings_bp.route('/store/ig-connect', methods=['POST'])
@jwt_required()
def connect_instagram():
    """
    連接 Instagram 帳號
    ---
    POST /api/v1/settings/store/ig-connect
    """
    user, store = get_current_user_and_store()
    
    if not user.is_owner:
        return jsonify({'error': {'code': 'permission_denied', 'message': '只有擁有者可以連接 Instagram'}}), 403
    
    data = request.json
    auth_code = data.get('auth_code')
    
    if not auth_code:
        return jsonify({'error': {'code': 'validation_error', 'message': '請提供 Instagram 授權碼'}}), 422
    
    try:
        ig_client = InstagramClient()
        token_data = ig_client.exchange_code_for_token(auth_code)
        
        store.ig_access_token = token_data['access_token']
        store.ig_user_id = token_data['user_id']
        store.ig_account = token_data.get('username')
        store.ig_token_expires_at = token_data.get('expires_at')
        
        db.session.commit()
        
        return jsonify({
            'message': 'Instagram 連接成功',
            'ig_account': store.ig_account
        })
        
    except Exception as e:
        return jsonify({'error': {'code': 'ig_connect_failed', 'message': str(e)}}), 500


@settings_bp.route('/store/ig-disconnect', methods=['POST'])
@jwt_required()
def disconnect_instagram():
    """
    斷開 Instagram 連接
    ---
    POST /api/v1/settings/store/ig-disconnect
    """
    user, store = get_current_user_and_store()
    
    if not user.is_owner:
        return jsonify({'error': {'code': 'permission_denied', 'message': '只有擁有者可以斷開 Instagram'}}), 403
    
    store.ig_access_token = None
    store.ig_user_id = None
    store.ig_account = None
    store.ig_token_expires_at = None
    
    db.session.commit()
    
    return jsonify({'message': 'Instagram 已斷開連接'})
