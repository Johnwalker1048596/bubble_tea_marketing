"""
AI 文案生成服務
使用 LangChain 概念實作，符合架構文件規範
"""
import os
from typing import Dict, Optional

class AIService:
    """
    AI 行銷文案生成服務
    整合天氣、趨勢、產品資訊生成客製化文案
    """
    
    def __init__(self):
        self.api_key = os.getenv('OPENAI_API_KEY')
        self.client = None
        
        if self.api_key:
            try:
                from openai import OpenAI
                self.client = OpenAI(api_key=self.api_key)
                print("✅ OpenAI API 初始化成功")
            except Exception as e:
                print(f"⚠️ OpenAI API 初始化失敗: {e}")
    
    def generate_content(self, 
                        product: Dict = None,
                        weather: str = None, 
                        trend: str = None,
                        rag_context: str = None,
                        custom_prompt: str = None) -> str:
        """
        生成行銷文案
        
        Args:
            product: 產品資訊 {'name', 'description', 'price', 'category'}
            weather: 天氣情境描述
            trend: 熱門趨勢
            rag_context: RAG 檢索的相關上下文
            custom_prompt: 使用者自訂要求
            
        Returns:
            生成的行銷文案
        """
        if not self.client:
            return self._generate_mock_content(product, weather, trend)
        
        # 建構 System Prompt
        system_prompt = """你是一位專業的飲料店社群行銷專家，擅長撰寫吸引人的 Instagram 貼文。

寫作風格：
- 使用繁體中文
- 活潑年輕、充滿活力
- 適當使用 emoji 增加視覺效果
- 包含 3-5 個相關 hashtag
- 文案長度約 100-150 字

目標：
- 引起顧客購買慾望
- 強調產品特色與口感
- 營造品牌親和力"""

        # 建構 User Prompt
        user_parts = ["請幫我撰寫一篇飲料店的 Instagram 行銷貼文。\n"]
        
        if product:
            user_parts.append("【推廣產品】")
            user_parts.append(f"名稱：{product.get('name', '招牌飲品')}")
            if product.get('description'):
                user_parts.append(f"特色：{product['description']}")
            if product.get('price'):
                user_parts.append(f"售價：${product['price']}")
            if product.get('category'):
                user_parts.append(f"分類：{product['category']}")
            user_parts.append("")
        
        if weather:
            user_parts.append(f"【今日天氣】\n{weather}\n")
        
        if trend:
            user_parts.append(f"【熱門趨勢】\n{trend}\n")
        
        if rag_context:
            user_parts.append(f"【參考資訊】\n{rag_context}\n")
        
        if custom_prompt:
            user_parts.append(f"【額外要求】\n{custom_prompt}")
        
        user_prompt = "\n".join(user_parts)
        
        try:
            response = self.client.chat.completions.create(
                model="gpt-3.5-turbo",
                messages=[
                    {"role": "system", "content": system_prompt},
                    {"role": "user", "content": user_prompt}
                ],
                max_tokens=500,
                temperature=0.8
            )
            return response.choices[0].message.content
            
        except Exception as e:
            print(f"❌ OpenAI API 錯誤: {e}")
            return self._generate_mock_content(product, weather, trend)
    
    def _generate_mock_content(self, product: Dict = None, 
                               weather: str = None, 
                               trend: str = None) -> str:
        """模擬生成（無 API Key 時使用）"""
        import random
        
        product_name = product.get('name', '招牌特調') if product else '招牌特調'
        
        # 根據天氣選擇模板
        if weather and ('熱' in weather or '晴' in weather):
            templates = [
                f"☀️ 熱到融化的日子，就是要來杯 {product_name}！\n\n冰涼沁心，一口消暑 🧊\n嚴選頂級茶葉 × 黃金比例調配\n每一口都是夏日的救贖 💕\n\n📍 迷克夏等你來清涼一下～\n\n#迷克夏 #手搖飲 #{product_name.replace(' ', '')} #消暑聖品 #夏日必備",
                f"🌞 今天 {product_name} 了嗎？\n\n炎炎夏日限定的清涼享受 ✨\n一杯入魂，暑氣全消\n冰涼順口，喝完還想再來一杯！\n\n🔥 現在點單享優惠\n\n#迷克夏 #夏季限定 #冰飲推薦 #手搖控 #消暑"
            ]
        else:
            templates = [
                f"🧋 {product_name} 新鮮現做中！\n\n嚴選頂級原料 🍃\n堅持每日新鮮調製\n給你最純粹的好味道 ✨\n\n一杯療癒你的下午時光 💕\n\n#迷克夏 #手搖杯 #飲料控 #下午茶 #必喝推薦",
                f"💫 你今天喝 {product_name} 了嗎？\n\n綿密口感 × 香醇茶底\n完美比例一喝就愛上 😍\n\n每一口都是幸福的味道～\n\n🎉 IG 打卡即享優惠\n\n#迷克夏 #奶茶控 #手搖飲推薦 #療癒系 #打卡美食",
                f"✨ 今日推薦：{product_name}\n\n用心調製的每一杯 🧋\n都是我們對品質的堅持\n喝過就知道什麼叫好喝！\n\n快來迷克夏品嚐吧 💕\n\n#迷克夏 #品質保證 #手搖飲 #飲料推薦 #必喝"
            ]
        
        return random.choice(templates)
    
    def generate_image_prompt(self, product: Dict = None, 
                              style: str = "美食攝影") -> str:
        """
        生成圖片 Prompt（給 NanoBanana 或 DALL-E 用）
        
        Args:
            product: 產品資訊
            style: 攝影風格
            
        Returns:
            英文圖片生成 prompt
        """
        product_name = product.get('name', 'bubble tea') if product else 'bubble tea'
        category = product.get('category', '') if product else ''
        
        # 中文轉英文對照
        drink_mapping = {
            '珍珠奶茶': 'pearl milk tea with tapioca',
            '波霸奶茶': 'boba milk tea with large tapioca',
            '黑糖珍珠': 'brown sugar pearl milk',
            '四季春': 'Four Seasons oolong tea',
            '綠茶': 'green tea',
            '紅茶': 'black tea',
            '奶茶': 'milk tea',
            '鮮奶': 'fresh milk tea',
            '水果茶': 'fruit tea',
            '檸檬': 'lemon tea',
        }
        
        drink_desc = 'Taiwanese bubble tea'
        for cn, en in drink_mapping.items():
            if cn in product_name:
                drink_desc = en
                break
        
        return f"""A beautiful {style} photo of {drink_desc}, 
Taiwanese hand-shaken drink in a clear plastic cup,
aesthetic composition, natural soft lighting, 
Instagram style food photography, 
bokeh background, high quality, 4k resolution,
warm and inviting atmosphere"""
