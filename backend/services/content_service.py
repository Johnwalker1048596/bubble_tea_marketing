"""內容生成服務 - LangChain 整合"""
from flask import current_app
from langchain_openai import ChatOpenAI
from langchain.prompts import PromptTemplate

from models import Product, Store
from services.weather_service import WeatherService
from services.trend_service import TrendService


class ContentService:
    """AI 內容生成服務"""
    
    def __init__(self):
        self.weather_service = WeatherService()
        self.trend_service = TrendService()
    
    def generate(
        self,
        store_id: str,
        product_id: str = None,
        include_weather: bool = True,
        include_trend: bool = True,
        custom_prompt: str = None
    ) -> dict:
        """
        生成行銷文案
        
        Args:
            store_id: 店家 ID
            product_id: 產品 ID（可選）
            include_weather: 是否包含天氣情境
            include_trend: 是否包含趨勢情境
            custom_prompt: 自訂 prompt
        
        Returns:
            dict: 包含生成文案、情境等資訊
        """
        store = Store.query.get(store_id)
        product = Product.query.get(product_id) if product_id else None
        
        # 收集情境資訊
        weather_context = None
        trend_context = None
        
        if include_weather:
            try:
                weather = self.weather_service.get_current_weather('Taipei')
                weather_context = f"{weather['temperature']}°C {weather['description']}"
            except:
                pass
        
        if include_trend:
            try:
                trends = self.trend_service.get_current_trends()
                if trends:
                    trend_context = ' '.join([f"#{t['keyword']}" for t in trends[:3]])
            except:
                pass
        
        # 建構 prompt
        prompt = self._build_prompt(
            store_name=store.name if store else '飲料店',
            product_name=product.name if product else None,
            product_description=product.description if product else None,
            weather_context=weather_context,
            trend_context=trend_context,
            custom_prompt=custom_prompt
        )
        
        # 呼叫 LLM
        generated_text = self._call_llm(prompt)
        
        return {
            'text': generated_text,
            'prompt': prompt,
            'product_name': product.name if product else None,
            'weather_context': weather_context,
            'trend_context': trend_context
        }
    
    def _build_prompt(
        self,
        store_name: str,
        product_name: str = None,
        product_description: str = None,
        weather_context: str = None,
        trend_context: str = None,
        custom_prompt: str = None
    ) -> str:
        """建構 AI Prompt"""
        
        template = """你是一個專業的飲料店社群行銷文案寫手。
請為「{store_name}」撰寫一則吸引人的 Instagram 貼文。

{product_info}

{weather_info}

{trend_info}

{custom_info}

要求：
1. 文案要活潑、吸引年輕族群
2. 適當使用 emoji
3. 加入 3-5 個相關 hashtag
4. 字數控制在 100-150 字
5. 要有明確的行動呼籲（CTA）

請直接輸出文案內容："""
        
        product_info = ""
        if product_name:
            product_info = f"推薦產品：{product_name}"
            if product_description:
                product_info += f"\n產品特色：{product_description}"
        
        weather_info = ""
        if weather_context:
            weather_info = f"今日天氣：{weather_context}（請根據天氣推薦適合的飲品）"
        
        trend_info = ""
        if trend_context:
            trend_info = f"熱門話題：{trend_context}（可適當融入文案）"
        
        custom_info = ""
        if custom_prompt:
            custom_info = f"額外要求：{custom_prompt}"
        
        return template.format(
            store_name=store_name,
            product_info=product_info,
            weather_info=weather_info,
            trend_info=trend_info,
            custom_info=custom_info
        )
    
    def _call_llm(self, prompt: str) -> str:
        """呼叫 LLM 生成文案"""
        try:
            llm = ChatOpenAI(
                model="gpt-3.5-turbo",
                temperature=0.7,
                max_tokens=500
            )
            response = llm.invoke(prompt)
            return response.content
        except Exception as e:
            # Fallback: 返回模板文案
            return self._get_fallback_content()
    
    def _get_fallback_content(self) -> str:
        """備用文案模板"""
        return """☀️ 今天也要來杯清涼的手搖飲！

我們家的招牌茶品，每一口都是滿滿的幸福感 🧋✨

新鮮茶葉現泡，堅持不加香精
給你最純粹的好味道！

📍 歡迎來店品嚐
🛵 外送平台同步供應中

#手搖飲 #飲料店 #今日限定 #消暑聖品 #必喝推薦"""
