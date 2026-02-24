"""
新聞趨勢服務 - 爬取熱門話題
符合架構文件的 TrendAnalyzer 模組
"""
import httpx
from bs4 import BeautifulSoup
from datetime import datetime
from typing import Dict, List
import random

class NewsService:
    """熱門趨勢分析服務"""
    
    def get_trending_topics(self) -> Dict:
        """
        取得熱門話題
        
        Returns:
            包含 topics 和 hashtags 的字典
        """
        try:
            # 嘗試爬取 Google Trends
            trends = self._fetch_google_trends()
            if trends:
                return trends
        except Exception as e:
            print(f"⚠️ 爬取趨勢失敗: {e}")
        
        # 使用季節性趨勢
        return self._get_seasonal_trends()
    
    def _fetch_google_trends(self) -> Dict:
        """嘗試爬取 Google Trends（簡化版）"""
        # 由於 Google Trends 需要複雜的處理，這裡返回 None 使用備用方案
        return None
    
    def _get_seasonal_trends(self) -> Dict:
        """根據季節和節日生成趨勢"""
        now = datetime.now()
        month = now.month
        day = now.day
        
        # 特殊節日
        special_days = {
            (1, 1): ['新年快樂', '2026', '新年新希望', '開工大吉'],
            (2, 14): ['情人節', '甜蜜', '告白', '浪漫約會'],
            (2, 5): ['元宵節', '湯圓', '團圓', '猜燈謎'],  # 農曆，這裡簡化
            (3, 8): ['婦女節', '女神節', '寵愛自己', '姐妹聚會'],
            (4, 4): ['兒童節', '童心', '回憶', '親子'],
            (5, 1): ['勞動節', '休假', '出遊', '連假'],
            (5, 11): ['母親節', '媽媽', '感恩', '康乃馨'],  # 第二個週日
            (6, 1): ['畢業季', '青春', '紀念', '告別'],
            (7, 7): ['七夕', '情人節', '牛郎織女', '浪漫'],
            (8, 8): ['父親節', '爸爸', '感謝', '超人老爸'],
            (9, 10): ['中秋節', '月餅', '烤肉', '團圓'],  # 農曆，這裡簡化
            (10, 31): ['萬聖節', 'Halloween', '搞怪', '南瓜'],
            (11, 11): ['雙11', '購物節', '優惠', '剁手'],
            (12, 25): ['聖誕節', '聖誕快樂', '交換禮物', '耶誕'],
            (12, 31): ['跨年', '倒數', '新年快樂', '告別2026'],
        }
        
        # 檢查是否有特殊節日（允許前後 3 天）
        for (m, d), topics in special_days.items():
            if m == month and abs(d - day) <= 3:
                return {
                    'topics': topics[:3],
                    'hashtags': ['#' + t.replace(' ', '') for t in topics],
                    'type': 'holiday',
                    'event': topics[0]
                }
        
        # 季節性趨勢
        seasonal = {
            1: ['冬季', '暖呼呼', '熱飲', '薑茶', '黑糖'],
            2: ['早春', '回暖', '春天', '櫻花', '粉嫩'],
            3: ['春天', '踏青', '野餐', '花季', '清新'],
            4: ['春雨', '連假', '出遊', '下午茶', '約會'],
            5: ['初夏', '消暑', '冰涼', '水果', '清爽'],
            6: ['夏日', '畢業', '暑假', '清涼', '芒果'],
            7: ['盛夏', '海邊', '消暑', '冰沙', '西瓜'],
            8: ['酷暑', '全糖', '冰涼', '解渴', '暢快'],
            9: ['初秋', '開學', '柚子', '月圓', '微涼'],
            10: ['秋天', '楓葉', '南瓜', '萬聖', '溫暖'],
            11: ['深秋', '冬季', '暖心', '雙11', '優惠'],
            12: ['冬天', '聖誕', '跨年', '溫暖', '療癒'],
        }
        
        month_topics = seasonal.get(month, ['手搖飲', '下午茶', '療癒'])
        
        return {
            'topics': random.sample(month_topics, min(3, len(month_topics))),
            'hashtags': ['#' + t for t in month_topics],
            'type': 'seasonal',
            'season': ['冬季', '春季', '春季', '春季', '夏季', '夏季', 
                       '夏季', '夏季', '秋季', '秋季', '秋季', '冬季'][month - 1]
        }
    
    def get_drink_news(self) -> List[Dict]:
        """取得飲料相關新聞"""
        # 模擬新聞資料（實際可串接新聞 API）
        news_templates = [
            {'title': '夏日消暑首選！網友票選最愛手搖飲TOP10', 'source': 'ETtoday'},
            {'title': '珍珠奶茶熱潮不退 日本掀起台灣茶飲風', 'source': '中央社'},
            {'title': '健康意識抬頭 低糖手搖飲成新趨勢', 'source': '自由時報'},
            {'title': '手搖飲品牌推新品 季節限定搶攻市場', 'source': 'TVBS'},
            {'title': '環保杯優惠加碼 手搖飲業者響應減塑', 'source': '聯合新聞網'},
        ]
        
        return random.sample(news_templates, min(3, len(news_templates)))
    
    def analyze_trend_relevance(self, product_name: str) -> Dict:
        """
        分析產品與趨勢的相關性
        
        Args:
            product_name: 產品名稱
            
        Returns:
            相關性分析結果
        """
        trends = self.get_trending_topics()
        
        # 簡單的關鍵字比對
        relevance_score = 0
        matched_trends = []
        
        product_lower = product_name.lower()
        
        # 夏季飲品相關
        summer_keywords = ['冰', '涼', '水果', '檸檬', '芒果', '西瓜', '冰沙']
        winter_keywords = ['熱', '暖', '薑', '黑糖', '桂圓', '紅棗']
        
        season = trends.get('season', '')
        
        if season in ['夏季'] and any(k in product_lower for k in summer_keywords):
            relevance_score += 0.3
            matched_trends.append('夏季消暑')
        
        if season in ['冬季'] and any(k in product_lower for k in winter_keywords):
            relevance_score += 0.3
            matched_trends.append('冬季暖心')
        
        return {
            'score': min(1.0, relevance_score),
            'matched_trends': matched_trends,
            'suggestion': self._get_marketing_suggestion(relevance_score, matched_trends)
        }
    
    def _get_marketing_suggestion(self, score: float, matched: List[str]) -> str:
        """生成行銷建議"""
        if score >= 0.5:
            return f"此產品與當前趨勢高度相關（{', '.join(matched)}），建議主打！"
        elif score >= 0.2:
            return f"可搭配趨勢行銷（{', '.join(matched)}）"
        else:
            return "建議強調產品本身特色"
