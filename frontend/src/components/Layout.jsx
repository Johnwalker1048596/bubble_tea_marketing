import React, { useState } from 'react';
import { Outlet, NavLink, useNavigate } from 'react-router-dom';

const menuItems = [
  { path: '/dashboard', icon: '📊', label: '儀表板' },
  { path: '/content/generate', icon: '✨', label: '生成貼文' },
  { path: '/content/history', icon: '📋', label: '歷史貼文' },
  { path: '/products', icon: '🧋', label: '產品管理' },
  { path: '/ingredients', icon: '🫘', label: '原物料管理' },
  { path: '/settings', icon: '⚙️', label: '系統設定' },
];

export default function Layout() {
  const navigate = useNavigate();
  const [collapsed, setCollapsed] = useState(false);

  const handleLogout = () => {
    localStorage.removeItem('token');
    navigate('/login');
  };

  return (
    <div className="flex h-screen bg-amber-50/50 bubble-bg">
      {/* 側邊欄 */}
      <aside
        className={`sidebar text-white transition-all duration-300 ${
          collapsed ? 'w-20' : 'w-64'
        } relative overflow-hidden`}
      >
        {/* 泡泡裝飾 */}
        <div className="absolute top-4 right-4 w-8 h-8 bg-white/10 rounded-full" />
        <div className="absolute top-20 right-8 w-4 h-4 bg-white/10 rounded-full" />
        <div className="absolute top-40 left-4 w-3 h-3 bg-white/10 rounded-full" />
        <div className="absolute bottom-32 left-4 w-6 h-6 bg-white/10 rounded-full" />
        <div className="absolute bottom-20 right-6 w-5 h-5 bg-white/10 rounded-full" />

        <div className="p-6 relative z-10">
          <div className="flex items-center gap-3">
            <span className="text-3xl">🧋</span>
            {!collapsed && <h1 className="text-xl font-bold">行銷助手</h1>}
          </div>
        </div>

        <nav className="mt-6 relative z-10">
          {menuItems.map((item) => (
            <NavLink
              key={item.path}
              to={item.path}
              className={({ isActive }) =>
                `flex items-center gap-4 px-6 py-4 transition-all hover:bg-white/10 ${
                  isActive ? 'bg-white/20 border-r-4 border-amber-300' : ''
                }`
              }
            >
              <span className="text-xl">{item.icon}</span>
              {!collapsed && <span>{item.label}</span>}
            </NavLink>
          ))}
        </nav>

        <div className="absolute bottom-0 w-full p-4 relative z-10">
          <button
            onClick={handleLogout}
            className="flex items-center gap-4 px-6 py-4 w-full text-left hover:bg-white/10 rounded-2xl transition-all"
          >
            <span className="text-xl">🚪</span>
            {!collapsed && <span>登出</span>}
          </button>
        </div>
      </aside>

      {/* 主內容區 */}
      <main className="flex-1 overflow-auto">
        <Outlet />
      </main>
    </div>
  );
}
