"""Instagram Graph API 客戶端"""
import requests
from flask import current_app


class InstagramClient:
    """Instagram API 客戶端"""
    
    GRAPH_API_URL = "https://graph.facebook.com/v18.0"
    
    def __init__(self):
        self.client_id = current_app.config.get('IG_CLIENT_ID')
        self.client_secret = current_app.config.get('IG_CLIENT_SECRET')
        self.redirect_uri = current_app.config.get('IG_REDIRECT_URI')
    
    def exchange_code_for_token(self, auth_code: str) -> dict:
        """
        用授權碼換取 access token
        
        Args:
            auth_code: Instagram OAuth 授權碼
        
        Returns:
            dict: 包含 access_token, user_id 等
        """
        # 短期 token
        response = requests.post(
            "https://api.instagram.com/oauth/access_token",
            data={
                'client_id': self.client_id,
                'client_secret': self.client_secret,
                'grant_type': 'authorization_code',
                'redirect_uri': self.redirect_uri,
                'code': auth_code
            }
        )
        
        if response.status_code != 200:
            raise Exception(f"Failed to get token: {response.text}")
        
        short_token_data = response.json()
        
        # 換取長期 token
        long_token_response = requests.get(
            f"{self.GRAPH_API_URL}/access_token",
            params={
                'grant_type': 'ig_exchange_token',
                'client_secret': self.client_secret,
                'access_token': short_token_data['access_token']
            }
        )
        
        if long_token_response.status_code == 200:
            long_token_data = long_token_response.json()
            return {
                'access_token': long_token_data['access_token'],
                'user_id': short_token_data['user_id'],
                'expires_in': long_token_data.get('expires_in')
            }
        
        return short_token_data
    
    def publish_post(
        self,
        access_token: str,
        user_id: str,
        caption: str,
        image_url: str = None
    ) -> dict:
        """
        發布貼文到 Instagram
        
        Args:
            access_token: 存取權杖
            user_id: Instagram 使用者 ID
            caption: 貼文內容
            image_url: 圖片 URL
        
        Returns:
            dict: 包含 post_id 和 permalink
        """
        if not image_url:
            raise Exception("Instagram 貼文需要圖片")
        
        # Step 1: 建立媒體容器
        create_response = requests.post(
            f"{self.GRAPH_API_URL}/{user_id}/media",
            params={
                'image_url': image_url,
                'caption': caption,
                'access_token': access_token
            }
        )
        
        if create_response.status_code != 200:
            raise Exception(f"Failed to create media: {create_response.text}")
        
        creation_id = create_response.json()['id']
        
        # Step 2: 發布媒體
        publish_response = requests.post(
            f"{self.GRAPH_API_URL}/{user_id}/media_publish",
            params={
                'creation_id': creation_id,
                'access_token': access_token
            }
        )
        
        if publish_response.status_code != 200:
            raise Exception(f"Failed to publish: {publish_response.text}")
        
        post_id = publish_response.json()['id']
        
        # Step 3: 取得貼文連結
        media_response = requests.get(
            f"{self.GRAPH_API_URL}/{post_id}",
            params={
                'fields': 'permalink',
                'access_token': access_token
            }
        )
        
        permalink = media_response.json().get('permalink') if media_response.status_code == 200 else None
        
        return {
            'post_id': post_id,
            'permalink': permalink
        }
