import docx
import os

def extract_all_images():
    # 讀取你的 docx 檔案
    doc = docx.Document("飲料文案fb&ig.docx")
    output_dir = "extracted_images"
    
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)
        
    print(f"🚀 開始地毯式搜索 Word 內的影像零件...")
    
    img_count = 0
    # 這是最暴力也最穩定的寫法：直接遍歷文件裡所有的關聯零件
    for part_name, part in doc.part.related_parts.items():
        # 如果這個零件的類型是「影像」
        if "image" in part.content_type:
            img_count += 1
            # 取得副檔名 (例如 png, jpeg)
            ext = part.content_type.split('/')[-1]
            file_path = os.path.join(output_dir, f"image_{img_count}.{ext}")
            
            with open(file_path, "wb") as f:
                f.write(part.blob)
                
    if img_count > 0:
        print(f"🎉 成功救出 {img_count} 張圖片！")
        print(f"📂 圖片都放在這裡了：{os.path.abspath(output_dir)}")
    else:
        print("⚠️ 還是抓不到...這份 Word 檔可能把圖片存在更奇怪的地方。")

if __name__ == "__main__":
    extract_all_images()