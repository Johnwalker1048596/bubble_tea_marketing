import React, { useState, useEffect } from 'react';

export default function Settings() {
  const [store, setStore] = useState(null);
  const [loading, setLoading] = useState(true);
  const token = localStorage.getItem('token');

  useEffect(() => {
    fetchStore();
  }, []);

  const fetchStore = async () => {
    try {
      const res = await fetch('/api/v1/settings/store', {
        headers: { 'Authorization': `Bearer ${token}` }
      });
      const data = await res.json();
      if (res.ok) {
        setStore(data);
      }
    } catch (err) {
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  const handleIGConnect = () => {
    // TODO: 實作 Instagram OAuth
    alert('Instagram 串接功能開發中');
  };

  if (loading) {
    return <div className="p-8 text-center text-gray-400">載入中...</div>;
  }

  return (
    <div className="p-8">
      <h1 className="text-3xl font-bold text-gray-800 mb-2">⚙️ 系統設定</h1>
      <p className="text-gray-500 mb-8">管理店家資訊與平台串接</p>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
        {/* 店家資訊 */}
        <div className="bg-white rounded-2xl p-6 shadow-sm">
          <h2 className="font-bold text-lg mb-6">店家資訊</h2>
          <div className="space-y-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">店家名稱</label>
              <input
                type="text"
                defaultValue={store?.name}
                className="input-field"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">地址</label>
              <input
                type="text"
                defaultValue={store?.address}
                className="input-field"
                placeholder="輸入店家地址"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">電話</label>
              <input
                type="text"
                defaultValue={store?.phone}
                className="input-field"
                placeholder="輸入聯絡電話"
              />
            </div>
            <button className="btn-primary">儲存變更</button>
          </div>
        </div>

        {/* Instagram 串接 */}
        <div className="bg-white rounded-2xl p-6 shadow-sm">
          <h2 className="font-bold text-lg mb-6">Instagram 串接</h2>
          
          {store?.ig_connected ? (
            <div className="space-y-4">
              <div className="flex items-center gap-4 p-4 bg-green-50 rounded-xl">
                <div className="w-12 h-12 bg-gradient-to-br from-purple-500 to-pink-500 rounded-xl flex items-center justify-center text-white text-xl">
                  📷
                </div>
                <div>
                  <p className="font-medium text-green-800">已連接</p>
                  <p className="text-sm text-green-600">@{store.ig_account}</p>
                </div>
              </div>
              <button className="btn-secondary w-full text-red-500">
                斷開連接
              </button>
            </div>
          ) : (
            <div className="text-center py-8">
              <div className="w-16 h-16 bg-gradient-to-br from-purple-500 to-pink-500 rounded-2xl flex items-center justify-center text-white text-3xl mx-auto mb-4">
                📷
              </div>
              <p className="text-gray-600 mb-4">連接 Instagram 帳號以一鍵發布貼文</p>
              <button onClick={handleIGConnect} className="btn-primary">
                連接 Instagram
              </button>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
