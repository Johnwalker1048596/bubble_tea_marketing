import React, { useState, useEffect } from 'react';

export default function ContentGenerate() {
  const [products, setProducts] = useState([]);
  const [selectedProduct, setSelectedProduct] = useState('');
  const [includeWeather, setIncludeWeather] = useState(true);
  const [includeTrend, setIncludeTrend] = useState(true);
  const [customPrompt, setCustomPrompt] = useState('');
  const [generating, setGenerating] = useState(false);
  const [result, setResult] = useState(null);
  const [weather, setWeather] = useState(null);
  const [trends, setTrends] = useState(null);

  const token = localStorage.getItem('token');

  useEffect(() => {
    fetchProducts();
    fetchWeather();
    fetchTrends();
  }, []);

  const fetchProducts = async () => {
    try {
      const res = await fetch('/api/v1/products', {
        headers: { 'Authorization': `Bearer ${token}` }
      });
      const data = await res.json();
      if (res.ok) setProducts(data.data || []);
    } catch (err) {
      console.error(err);
    }
  };

  const fetchWeather = async () => {
    try {
      const res = await fetch('/api/v1/weather', {
        headers: { 'Authorization': `Bearer ${token}` }
      });
      const data = await res.json();
      if (res.ok) setWeather(data);
    } catch (err) {
      console.error(err);
    }
  };

  const fetchTrends = async () => {
    try {
      const res = await fetch('/api/v1/trends', {
        headers: { 'Authorization': `Bearer ${token}` }
      });
      const data = await res.json();
      if (res.ok) setTrends(data);
    } catch (err) {
      console.error(err);
    }
  };

  const handleGenerate = async () => {
    setGenerating(true);
    setResult(null);

    try {
      const res = await fetch('/api/v1/content/generate', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`
        },
        body: JSON.stringify({
          product_id: selectedProduct || null,
          include_weather: includeWeather,
          include_trend: includeTrend,
          custom_prompt: customPrompt
        })
      });

      const data = await res.json();

      if (res.ok) {
        setResult(data.content);
      } else {
        alert(data.error?.message || '生成失敗');
      }
    } catch (err) {
      alert('網路錯誤');
    } finally {
      setGenerating(false);
    }
  };

  const handlePublish = async () => {
    if (!result) return;
    
    try {
      const res = await fetch(`/api/v1/content/${result.id}/publish`, {
        method: 'POST',
        headers: { 'Authorization': `Bearer ${token}` }
      });
      
      const data = await res.json();
      if (res.ok) {
        alert('發布成功！' + (data.note ? `\n\n${data.note}` : ''));
        setResult({ ...result, status: 'published' });
      }
    } catch (err) {
      alert('發布失敗');
    }
  };

  const handleSaveDraft = async () => {
    if (!result) return;
    alert('已儲存為草稿！');
  };

  return (
    <div className="p-8">
      <h1 className="text-3xl font-bold text-gray-800 mb-2">✨ 生成貼文</h1>
      <p className="text-gray-500 mb-8">使用 AI 智能生成吸睛的行銷文案</p>

      {/* 天氣和趨勢資訊卡 */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-8">
        {weather && (
          <div className="bg-gradient-to-r from-blue-500 to-cyan-500 rounded-xl p-4 text-white">
            <div className="flex items-center gap-3">
              <span className="text-3xl">
                {weather.condition?.includes('雨') ? '🌧️' : 
                 weather.condition?.includes('雲') ? '⛅' : '☀️'}
              </span>
              <div>
                <div className="font-bold">{weather.condition} {weather.temperature}°C</div>
                <div className="text-sm opacity-90">{weather.recommendation}</div>
              </div>
            </div>
          </div>
        )}
        
        {trends && (
          <div className="bg-gradient-to-r from-purple-500 to-pink-500 rounded-xl p-4 text-white">
            <div className="flex items-center gap-3">
              <span className="text-3xl">📈</span>
              <div>
                <div className="font-bold">熱門趨勢</div>
                <div className="text-sm opacity-90">
                  {trends.trends?.topics?.join(' · ')}
                </div>
              </div>
            </div>
          </div>
        )}
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
        {/* 左側：設定區 */}
        <div className="bg-white rounded-2xl p-6 shadow-sm">
          <h2 className="font-bold text-lg mb-6">生成設定</h2>

          <div className="space-y-6">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                選擇產品（可選）
              </label>
              <select
                value={selectedProduct}
                onChange={(e) => setSelectedProduct(e.target.value)}
                className="input-field"
              >
                <option value="">不指定產品（隨機推薦）</option>
                {products.map((p) => (
                  <option key={p.id} value={p.id}>
                    {p.name} - ${p.price}
                  </option>
                ))}
              </select>
            </div>

            <div className="flex items-center gap-6">
              <label className="flex items-center gap-2 cursor-pointer">
                <input
                  type="checkbox"
                  checked={includeWeather}
                  onChange={(e) => setIncludeWeather(e.target.checked)}
                  className="w-5 h-5 text-green-500 rounded"
                />
                <span>☀️ 加入天氣情境</span>
              </label>

              <label className="flex items-center gap-2 cursor-pointer">
                <input
                  type="checkbox"
                  checked={includeTrend}
                  onChange={(e) => setIncludeTrend(e.target.checked)}
                  className="w-5 h-5 text-green-500 rounded"
                />
                <span>📈 加入熱門趨勢</span>
              </label>
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                額外要求（可選）
              </label>
              <textarea
                value={customPrompt}
                onChange={(e) => setCustomPrompt(e.target.value)}
                className="input-field h-24 resize-none"
                placeholder="例：強調健康、使用更多 emoji、針對上班族..."
              />
            </div>

            <button
              onClick={handleGenerate}
              disabled={generating}
              className="btn-primary w-full disabled:opacity-50"
            >
              {generating ? (
                <span className="flex items-center justify-center gap-2">
                  <span className="animate-spin">⏳</span>
                  AI 生成中...
                </span>
              ) : (
                '🚀 開始生成'
              )}
            </button>
          </div>
        </div>

        {/* 右側：結果區 */}
        <div className="bg-white rounded-2xl p-6 shadow-sm">
          <h2 className="font-bold text-lg mb-6">生成結果</h2>

          {result ? (
            <div className="space-y-4">
              {result.weather_context && (
                <div className="bg-blue-50 text-blue-700 px-4 py-2 rounded-lg text-sm">
                  ☀️ {result.weather_context}
                </div>
              )}
              
              {result.trend_context && (
                <div className="bg-purple-50 text-purple-700 px-4 py-2 rounded-lg text-sm">
                  📈 趨勢：{result.trend_context}
                </div>
              )}

              {result.product_name && (
                <div className="bg-green-50 text-green-700 px-4 py-2 rounded-lg text-sm">
                  🧋 產品：{result.product_name}
                </div>
              )}

              <div className="bg-gray-50 rounded-xl p-4">
                <p className="whitespace-pre-wrap text-gray-800 leading-relaxed">
                  {result.generated_text}
                </p>
              </div>

              <div className="flex items-center gap-2 text-sm text-gray-500">
                <span className={`px-2 py-1 rounded ${
                  result.status === 'published' 
                    ? 'bg-green-100 text-green-700' 
                    : 'bg-gray-100 text-gray-600'
                }`}>
                  {result.status === 'published' ? '✅ 已發布' : '📝 草稿'}
                </span>
              </div>

              <div className="flex gap-3">
                <button 
                  onClick={handlePublish}
                  disabled={result.status === 'published'}
                  className="btn-primary flex-1 disabled:opacity-50"
                >
                  📤 發布到 Instagram
                </button>
                <button 
                  onClick={handleSaveDraft}
                  className="btn-secondary flex-1"
                >
                  💾 儲存草稿
                </button>
              </div>
            </div>
          ) : (
            <div className="h-64 flex items-center justify-center text-gray-400">
              <div className="text-center">
                <div className="text-5xl mb-4">✨</div>
                <p>設定完成後點擊「開始生成」</p>
                <p className="text-sm mt-2">AI 將根據天氣、趨勢自動生成文案</p>
              </div>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
