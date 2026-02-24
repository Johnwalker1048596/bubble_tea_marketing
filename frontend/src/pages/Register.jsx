import React, { useState } from 'react';
import { useNavigate, Link } from 'react-router-dom';

export default function Register() {
  const [formData, setFormData] = useState({
    store_name: '',
    email: '',
    password: '',
    confirmPassword: ''
  });
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();
    
    if (formData.password !== formData.confirmPassword) {
      setError('密碼不一致');
      return;
    }
    
    setLoading(true);
    setError('');

    try {
      const res = await fetch('/api/v1/auth/register', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          store_name: formData.store_name,
          email: formData.email,
          password: formData.password
        })
      });

      const data = await res.json();

      if (res.ok) {
        navigate('/login');
      } else {
        setError(data.error?.message || '註冊失敗');
      }
    } catch (err) {
      setError('網路錯誤，請稍後再試');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen flex">
      {/* 左側裝飾 */}
      <div className="hidden lg:flex lg:w-1/2 bg-gradient-to-br from-emerald-500 to-green-600 items-center justify-center p-12">
        <div className="text-white max-w-md">
          <h1 className="text-5xl font-bold mb-6">🚀</h1>
          <h2 className="text-3xl font-bold mb-4">開始您的行銷之旅</h2>
          <p className="text-lg opacity-90">
            註冊後即可享受 AI 智能文案生成、天氣情境推薦、一鍵發布等強大功能。
          </p>
        </div>
      </div>

      {/* 右側表單 */}
      <div className="w-full lg:w-1/2 flex items-center justify-center p-8">
        <div className="w-full max-w-md">
          <div className="text-center mb-8">
            <h2 className="text-3xl font-bold text-gray-800">建立帳號</h2>
            <p className="text-gray-500 mt-2">免費開始使用</p>
          </div>

          {error && (
            <div className="bg-red-50 border border-red-200 text-red-600 px-4 py-3 rounded-xl mb-6">
              {error}
            </div>
          )}

          <form onSubmit={handleSubmit} className="space-y-5">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                店家名稱
              </label>
              <input
                type="text"
                value={formData.store_name}
                onChange={(e) => setFormData({...formData, store_name: e.target.value})}
                className="input-field"
                placeholder="例：幸福茶飲"
                required
              />
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Email
              </label>
              <input
                type="email"
                value={formData.email}
                onChange={(e) => setFormData({...formData, email: e.target.value})}
                className="input-field"
                placeholder="your@email.com"
                required
              />
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                密碼
              </label>
              <input
                type="password"
                value={formData.password}
                onChange={(e) => setFormData({...formData, password: e.target.value})}
                className="input-field"
                placeholder="至少 6 個字元"
                minLength={6}
                required
              />
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                確認密碼
              </label>
              <input
                type="password"
                value={formData.confirmPassword}
                onChange={(e) => setFormData({...formData, confirmPassword: e.target.value})}
                className="input-field"
                placeholder="再次輸入密碼"
                required
              />
            </div>

            <button
              type="submit"
              disabled={loading}
              className="btn-primary w-full disabled:opacity-50"
            >
              {loading ? '註冊中...' : '註冊'}
            </button>
          </form>

          <p className="mt-8 text-center text-gray-500">
            已有帳號？{' '}
            <Link to="/login" className="text-green-600 font-medium hover:underline">
              立即登入
            </Link>
          </p>
        </div>
      </div>
    </div>
  );
}
