"""
天氣服務 - 使用 Open-Meteo 免費 API
符合架構文件的 WeatherAnalyzer 模組
"""
import httpx
from typing import Dict

class WeatherService:
    """天氣資料分析服務"""
    
    BASE_URL = "https://api.open-meteo.com/v1/forecast"
    
    # 台灣主要城市座標
    CITIES = {
        'taipei': {'lat': 25.0330, 'lon': 121.5654, 'name': '台北'},
        'taichung': {'lat': 24.1477, 'lon': 120.6736, 'name': '台中'},
        'kaohsiung': {'lat': 22.6273, 'lon': 120.3014, 'name': '高雄'},
        'tainan': {'lat': 22.9908, 'lon': 120.2133, 'name': '台南'},
        'hsinchu': {'lat': 24.8138, 'lon': 120.9675, 'name': '新竹'},
    }
    
    def get_weather(self, city: str = 'taipei') -> Dict:
        """
        取得天氣資訊
        
        Args:
            city: 城市代碼
            
        Returns:
            天氣資訊字典
        """
        try:
            city_info = self.CITIES.get(city, self.CITIES['taipei'])
            
            response = httpx.get(
                self.BASE_URL,
                params={
                    'latitude': city_info['lat'],
                    'longitude': city_info['lon'],
                    'current': 'temperature_2m,weather_code,relative_humidity_2m,apparent_temperature',
                    'timezone': 'Asia/Taipei'
                },
                timeout=10
            )
            
            data = response.json()
            current = data.get('current', {})
            
            temp = current.get('temperature_2m', 25)
            feels_like = current.get('apparent_temperature', temp)
            humidity = current.get('relative_humidity_2m', 60)
            weather_code = current.get('weather_code', 0)
            
            condition = self._get_condition(weather_code)
            recommendation = self._get_recommendation(temp, weather_code, humidity)
            
            return {
                'city': city_info['name'],
                'temperature': temp,
                'feels_like': feels_like,
                'humidity': humidity,
                'condition': condition,
                'weather_code': weather_code,
                'recommendation': recommendation,
                'description': f"{condition}，{temp}°C（體感 {feels_like}°C），濕度 {humidity}%"
            }
            
        except Exception as e:
            print(f"⚠️ 天氣 API 錯誤: {e}")
            return self._get_fallback_weather()
    
    def _get_condition(self, code: int) -> str:
        """天氣代碼轉中文"""
        conditions = {
            0: '晴天',
            1: '晴時多雲',
            2: '多雲',
            3: '陰天',
            45: '有霧',
            48: '霧濛濛',
            51: '毛毛雨',
            53: '小雨',
            55: '中雨',
            61: '間歇小雨',
            63: '間歇中雨',
            65: '間歇大雨',
            71: '小雪',
            73: '中雪',
            75: '大雪',
            80: '陣雨',
            81: '中陣雨',
            82: '大陣雨',
            95: '雷陣雨',
            96: '雷陣雨夾冰雹',
            99: '強烈雷陣雨'
        }
        return conditions.get(code, '晴天')
    
    def _get_recommendation(self, temp: float, code: int, humidity: int) -> str:
        """根據天氣給出飲品推薦"""
        
        # 根據溫度
        if temp >= 32:
            temp_rec = "超熱天氣！強烈推薦冰涼消暑飲品：冰沙、水果茶、冬瓜茶、仙草凍飲"
        elif temp >= 28:
            temp_rec = "炎熱天氣，推薦清涼飲品：冰綠茶、水果茶、檸檬系列、冰淇淋紅茶"
        elif temp >= 24:
            temp_rec = "舒適天氣，推薦清爽茶飲：四季春、烏龍茶、茉莉綠茶、鮮果茶"
        elif temp >= 20:
            temp_rec = "微涼天氣，推薦溫潤奶茶：珍珠奶茶、烏龍拿鐵、芋頭鮮奶"
        else:
            temp_rec = "天氣較涼，推薦溫熱飲品：熱奶茶、黑糖薑茶、熱可可、桂圓紅棗茶"
        
        # 根據天氣狀況
        if code >= 51:  # 下雨
            weather_rec = "雨天適合待在店裡，來杯暖心飲品吧！"
        elif code >= 45:  # 霧
            weather_rec = "霧濛濛的天氣，來杯熱飲暖暖身～"
        else:
            weather_rec = ""
        
        return f"{temp_rec}{' ' + weather_rec if weather_rec else ''}"
    
    def _get_fallback_weather(self) -> Dict:
        """備用天氣資料"""
        return {
            'city': '台北',
            'temperature': 28,
            'feels_like': 30,
            'humidity': 65,
            'condition': '晴時多雲',
            'weather_code': 1,
            'recommendation': '舒適天氣，推薦清爽茶飲：四季春、烏龍茶、茉莉綠茶',
            'description': '晴時多雲，28°C（體感 30°C），濕度 65%'
        }
