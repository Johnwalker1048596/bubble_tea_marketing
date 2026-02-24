import docx
import re
from sqlalchemy import create_engine, text

# 1. 連線設定
DB_URL = "postgresql://postgres:postgres@localhost:5432/bubble_tea"
engine = create_engine(DB_URL)

def import_word_content_v3():
    try:
        doc = docx.Document("飲料文案fb&ig.docx")
        
        # 把所有文字合併，保留換行
        full_text = "\n".join([p.text for p in doc.paragraphs])
        
        # 🚀 核心邏輯：用日期格式 (例如 2026/01/21) 來切分文案
        # 這個正則會去找 4位數字/2位數字/2位數字
        pattern = r'(\d{4}/\d{2}/\d{2})'
        
        # 進行切分
        parts = re.split(pattern, full_text)
        
        # 因為 re.split 會把「日期」跟「內容」拆開，我們要把它們黏回來
        # parts[0] 通常是開頭的標題 (如 FB & IG: 功夫茶)
        header = parts[0].strip()
        
        valid_posts = []
        for i in range(1, len(parts), 2):
            date = parts[i]
            content = parts[i+1].strip() if (i+1) < len(parts) else ""
            # 把日期跟內容拼在一起，並加上剛才抓到的 Header 資訊
            full_post = f"{header}\n{date}\n{content}"
            valid_posts.append(full_post)

        print(f"✅ 重新過濾後，成功抓到 {len(valid_posts)} 篇完整的文案！")

        # 2. 先清空舊的碎掉資料，再重新匯入
        with engine.begin() as conn:
            conn.execute(text("DELETE FROM marketing_content;"))
            
            sql = text("""
                INSERT INTO marketing_content (store_id, final_text, status) 
                VALUES (1, :text, 'published')
            """)
            
            for post_text in valid_posts:
                conn.execute(sql, {"text": post_text})
        
        print("🎉 終極修正版匯入完成！去 DBeaver 慶祝吧！")

    except Exception as e:
        print(f"❌ 錯誤: {e}")

if __name__ == "__main__":
    import_word_content_v3()