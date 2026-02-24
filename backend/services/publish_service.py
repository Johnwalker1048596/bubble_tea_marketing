"""發布服務 - Instagram 整合"""
from models import Store, MarketingContent
from utils.instagram_client import InstagramClient


class PublishService:
    """社群發布服務"""
    
    def __init__(self):
        self.ig_client = InstagramClient()
    
    def publish_to_instagram(self, store_id: str, content: MarketingContent) -> dict:
        """
        發布內容到 Instagram
        
        Args:
            store_id: 店家 ID
            content: 行銷內容
        
        Returns:
            dict: 包含 post_id 和 permalink
        """
        store = Store.query.get(store_id)
        
        if not store.ig_connected:
            raise Exception('Instagram 尚未連接')
        
        # 取得圖片 URL
        image_url = None
        if content.images:
            primary_image = next(
                (img for img in content.images if img.is_primary),
                content.images[0]
            )
            image_url = primary_image.image_url
        
        # 發布到 Instagram
        result = self.ig_client.publish_post(
            access_token=store.ig_access_token,
            user_id=store.ig_user_id,
            caption=content.display_text,
            image_url=image_url
        )
        
        return result
