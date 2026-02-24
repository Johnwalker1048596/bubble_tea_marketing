"""趨勢分析服務"""
from flask import current_app


class TrendService:
    """趨勢分析服務"""
    
    def get_current_trends(self) -> list:
        """
        取得目前熱門趨勢
        
        Returns:
            list: 趨勢列表
        """
        # TODO: 整合實際趨勢 API (Google Trends, Twitter API 等)
        # 目前返回模擬資料
        return self._get_mock_trends()
    
    def _get_mock_trends(self) -> list:
        """模擬趨勢資料"""
        return [
            {
                'keyword': '消暑',
                'relevance': 0.95,
                'suggestion': '推薦冰涼飲品'
            },
            {
                'keyword': '夏日限定',
                'relevance': 0.85,
                'suggestion': '強調季節限定'
            },
            {
                'keyword': '手搖控',
                'relevance': 0.80,
                'suggestion': '針對手搖飲愛好者'
            }
        ]
    
    def analyze_relevance(self, keywords: list, product_name: str) -> float:
        """
        分析關鍵字與產品的相關性
        
        Args:
            keywords: 關鍵字列表
            product_name: 產品名稱
        
        Returns:
            float: 相關性分數 (0-1)
        """
        # 簡單的關鍵字匹配
        product_lower = product_name.lower()
        matches = sum(1 for kw in keywords if kw.lower() in product_lower)
        return min(matches / len(keywords), 1.0) if keywords else 0
