import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';

export default function Dashboard() {
  const [stats, setStats] = useState({
    totalContents: 0,
    publishedContents: 0,
    draftContents: 0,
    totalProducts: 0
  });
  const [weather, setWeather] = useState(null);
  const user = JSON.parse(localStorage.getItem('user') || '{}');

  useEffect(() => {
    // 可以在這裡載入統計資料
  }, []);

  const quickActions = [
    { icon: '✨', title: '生成新貼文', desc: 'AI 智能生成行銷文案', path: '/content/generate', color: 'from-purple-500 to-indigo-600' },
    { icon: '📋', title: '查看歷史', desc: '管理已發布的貼文', path: '/content/history', color: 'from-blue-500 to-cyan-600' },
    { icon: '🧋', title: '產品管理', desc: '新增或編輯飲品', path: '/products', color: 'from-orange-500 to-amber-600' },
    { icon: '⚙️', title: '系統設定', desc: 'Instagram 串接', path: '/settings', color: 'from-gray-600 to-gray-800' },
  ];

  return (
    <div className="p-8">
      {/* 歡迎區塊 */}
      <div className="mb-8">
        <h1 className="text-3xl font-bold text-gray-800">
          早安！👋
        </h1>
        <p className="text-gray-500 mt-1">歡迎回到行銷助手，今天想發什麼貼文呢？</p>
      </div>

      {/* 統計卡片 */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
        <div className="bg-white rounded-2xl p-6 shadow-sm">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-gray-500 text-sm">總貼文數</p>
              <p className="text-3xl font-bold text-gray-800 mt-1">{stats.totalContents}</p>
            </div>
            <div className="w-12 h-12 bg-purple-100 rounded-xl flex items-center justify-center text-2xl">
              📝
            </div>
          </div>
        </div>
        
        <div className="bg-white rounded-2xl p-6 shadow-sm">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-gray-500 text-sm">已發布</p>
              <p className="text-3xl font-bold text-green-600 mt-1">{stats.publishedContents}</p>
            </div>
            <div className="w-12 h-12 bg-green-100 rounded-xl flex items-center justify-center text-2xl">
              ✅
            </div>
          </div>
        </div>
        
        <div className="bg-white rounded-2xl p-6 shadow-sm">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-gray-500 text-sm">草稿</p>
              <p className="text-3xl font-bold text-orange-600 mt-1">{stats.draftContents}</p>
            </div>
            <div className="w-12 h-12 bg-orange-100 rounded-xl flex items-center justify-center text-2xl">
              📋
            </div>
          </div>
        </div>
        
        <div className="bg-white rounded-2xl p-6 shadow-sm">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-gray-500 text-sm">產品數</p>
              <p className="text-3xl font-bold text-blue-600 mt-1">{stats.totalProducts}</p>
            </div>
            <div className="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center text-2xl">
              🧋
            </div>
          </div>
        </div>
      </div>

      {/* 快速操作 */}
      <h2 className="text-xl font-bold text-gray-800 mb-4">快速操作</h2>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
        {quickActions.map((action, idx) => (
          <Link
            key={idx}
            to={action.path}
            className="bg-white rounded-2xl p-6 shadow-sm card-hover transition-all duration-300"
          >
            <div className={`w-14 h-14 bg-gradient-to-br ${action.color} rounded-xl flex items-center justify-center text-2xl text-white mb-4`}>
              {action.icon}
            </div>
            <h3 className="font-bold text-gray-800">{action.title}</h3>
            <p className="text-gray-500 text-sm mt-1">{action.desc}</p>
          </Link>
        ))}
      </div>

      {/* 天氣推薦 */}
      <div className="bg-gradient-to-r from-blue-500 to-cyan-500 rounded-2xl p-6 text-white">
        <div className="flex items-center justify-between">
          <div>
            <h3 className="font-bold text-lg">☀️ 今日天氣：28°C 晴天</h3>
            <p className="opacity-90 mt-1">建議推薦冰涼消暑的飲品，如：冰綠茶、水果茶系列</p>
          </div>
          <Link
            to="/content/generate"
            className="bg-white/20 hover:bg-white/30 px-6 py-3 rounded-xl font-medium transition-all"
          >
            生成推薦文案 →
          </Link>
        </div>
      </div>
    </div>
  );
}
