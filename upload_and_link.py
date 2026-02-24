import os
from minio import Minio
from sqlalchemy import create_engine, text

# 1. 連線資訊 (對應你的 docker-compose)
DB_URL = "postgresql://postgres:postgres@localhost:5432/bubble_tea"
MINIO_URL = "localhost:9000"
MINIO_ACCESS = "minioadmin"
MINIO_SECRET = "minioadmin"
BUCKET_NAME = "marketing"

engine = create_engine(DB_URL)
minio_client = Minio(MINIO_URL, access_key=MINIO_ACCESS, secret_key=MINIO_SECRET, secure=False)

def start_process():
    # A. 確保 MinIO 有 Bucket 且設為公開 (這樣網頁才看得到圖)
    if not minio_client.bucket_exists(BUCKET_NAME):
        minio_client.make_bucket(BUCKET_NAME)
        # 設定公開讀取權限的 Policy
        policy = '{"Version":"2012-10-17","Statement":[{"Effect":"Allow","Principal":{"AWS":["*"]},"Action":["s3:GetBucketLocation","s3:ListBucket"],"Resource":["arn:aws:s3:::%s"]},{"Effect":"Allow","Principal":{"AWS":["*"]},"Action":["s3:GetObject"],"Resource":["arn:aws:s3:::%s/*"]}]}' % (BUCKET_NAME, BUCKET_NAME)
        minio_client.set_bucket_policy(BUCKET_NAME, policy)

    # B. 抓取所有圖片路徑
    image_dir = "extracted_images"
    images = sorted([f for f in os.listdir(image_dir) if f.endswith(('.png', '.jpg', '.jpeg'))])
    
    # C. 取得資料庫中的文案 ID 清單
    with engine.connect() as conn:
        result = conn.execute(text("SELECT id FROM marketing_content ORDER BY id"))
        content_ids = [row[0] for row in result]

    if not content_ids:
        print("❌ 資料庫裡沒有文案，請先跑之前的文案匯入腳本！")
        return

    print(f"🚀 開始上傳 {len(images)} 張圖片並關聯至 {len(content_ids)} 筆文案...")

    # D. 開始循環上傳與寫入資料庫
    with engine.begin() as conn:
        for i, img_name in enumerate(images):
            # 這裡用簡單的餘數邏輯，把 255 張圖平均分配給 103 筆文案
            related_content_id = content_ids[i % len(content_ids)]
            file_path = os.path.join(image_dir, img_name)
            
            # 上傳到 MinIO
            minio_client.fput_object(BUCKET_NAME, img_name, file_path)
            
            # 產出對外網址
            img_url = f"http://localhost:9000/{BUCKET_NAME}/{img_name}"
            
            # 寫入 content_image 資料表
            conn.execute(text("""
                INSERT INTO content_image (content_id, minio_url, prompt_used) 
                VALUES (:c_id, :url, :prompt)
            """), {"c_id": related_content_id, "url": img_url, "prompt": "Extracted from original docx"})

    print(f"🎉 大功告成！圖片已全部上傳並完成資料庫關聯！")

if __name__ == "__main__":
    start_process()