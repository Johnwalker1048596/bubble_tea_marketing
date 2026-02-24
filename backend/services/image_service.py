"""圖片生成服務 - NanoBanana API 整合"""
import requests
from flask import current_app

from utils.minio_client import MinIOClient


class ImageService:
    """AI 圖片生成服務"""
    
    def __init__(self):
        self.api_key = current_app.config.get('NANOBANANA_API_KEY')
        self.api_url = current_app.config.get('NANOBANANA_API_URL')
        self.minio_client = MinIOClient()
    
    def generate(
        self,
        content_id: str,
        product_name: str = None,
        style_hints: str = None
    ) -> dict | None:
        """
        生成行銷圖片
        
        Args:
            content_id: 內容 ID
            product_name: 產品名稱
            style_hints: 風格提示
        
        Returns:
            dict: 包含圖片 URL 和 prompt
        """
        if not self.api_key:
            return None
        
        prompt = self._build_image_prompt(product_name, style_hints)
        
        try:
            # 呼叫 NanoBanana API
            image_data = self._call_nanobanana(prompt)
            
            if image_data:
                # 上傳到 MinIO
                filename = f"content-{content_id}.png"
                url = self.minio_client.upload_image(
                    image_data,
                    filename
                )
                
                return {
                    'url': url,
                    'prompt': prompt
                }
        except Exception as e:
            current_app.logger.error(f"Image generation failed: {e}")
        
        return None
    
    def _build_image_prompt(self, product_name: str, style_hints: str) -> str:
        """建構圖片生成 prompt"""
        base_prompt = "A refreshing bubble tea drink, professional food photography, soft lighting, clean background"
        
        if product_name:
            base_prompt += f", {product_name}"
        
        if style_hints:
            base_prompt += f", {style_hints}"
        
        return base_prompt
    
    def _call_nanobanana(self, prompt: str) -> bytes | None:
        """呼叫 NanoBanana API"""
        headers = {
            'Authorization': f'Bearer {self.api_key}',
            'Content-Type': 'application/json'
        }
        
        payload = {
            'prompt': prompt,
            'width': 1024,
            'height': 1024,
            'num_images': 1
        }
        
        response = requests.post(
            f"{self.api_url}/generate",
            headers=headers,
            json=payload,
            timeout=60
        )
        
        if response.status_code == 200:
            data = response.json()
            if data.get('images'):
                # 下載圖片
                image_url = data['images'][0]['url']
                img_response = requests.get(image_url)
                return img_response.content
        
        return None
