"""MinIO 客戶端"""
from minio import Minio
from flask import current_app
import io


class MinIOClient:
    """MinIO 檔案儲存客戶端"""
    
    def __init__(self):
        self.client = Minio(
            current_app.config['MINIO_ENDPOINT'],
            access_key=current_app.config['MINIO_ACCESS_KEY'],
            secret_key=current_app.config['MINIO_SECRET_KEY'],
            secure=current_app.config['MINIO_SECURE']
        )
        self.bucket = current_app.config['MINIO_BUCKET']
        self._ensure_bucket()
    
    def _ensure_bucket(self):
        """確保 bucket 存在"""
        if not self.client.bucket_exists(self.bucket):
            self.client.make_bucket(self.bucket)
    
    def upload_image(self, image_data: bytes, filename: str) -> str:
        """
        上傳圖片
        
        Args:
            image_data: 圖片二進位資料
            filename: 檔案名稱
        
        Returns:
            str: 圖片 URL
        """
        self.client.put_object(
            self.bucket,
            filename,
            io.BytesIO(image_data),
            length=len(image_data),
            content_type='image/png'
        )
        
        return f"http://{current_app.config['MINIO_ENDPOINT']}/{self.bucket}/{filename}"
    
    def delete_image(self, filename: str):
        """刪除圖片"""
        self.client.remove_object(self.bucket, filename)
    
    def get_presigned_url(self, filename: str, expires: int = 3600) -> str:
        """取得預簽名 URL"""
        from datetime import timedelta
        return self.client.presigned_get_object(
            self.bucket,
            filename,
            expires=timedelta(seconds=expires)
        )
