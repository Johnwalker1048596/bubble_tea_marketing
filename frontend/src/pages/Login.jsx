import React, { useState } from 'react';
import { useNavigate, Link } from 'react-router-dom';

export default function Login() {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    setError('');
    
    try {
      const res = await fetch('/api/v1/auth/login', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email, password })
      });
      
      const data = await res.json();
      
      if (res.ok) {
        localStorage.setItem('token', data.access_token);
        localStorage.setItem('user', JSON.stringify(data.user));
        navigate('/dashboard');
      } else {
        setError(data.error?.message || '登入失敗');
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
      <div className="hidden lg:flex lg:w-1/2 bg-gradient-to-br from-green-400 to-emerald-600 items-center justify-center p-12">
        <div className="text-white max-w-md">
          <h1 className="text-5xl font-bold mb-6">🧋</h1>
          <h2 className="text-3xl font-bold mb-4">飲料店行銷助手</h2>
          <p className="text-lg opacity-90">
            AI 驅動的社群行銷工具，一鍵生成吸睛文案與精美圖片，輕鬆管理 Instagram 貼文。
          </p>
          <div className="mt-8 flex gap-4">
            <div className="bg-white/20 backdrop-blur rounded-xl p-4">
              <div className="text-2xl font-bold">AI 文案</div>
              <div className="text-sm opacity-80">智能生成</div>
            </div>
            <div className="bg-white/20 backdrop-blur rounded-xl p-4">
              <div className="text-2xl font-bold">一鍵發布</div>
              <div className="text-sm opacity-80">Instagram</div>
            </div>
          </div>
        </div>
      </div>

      {/* 右側表單 */}
      <div className="w-full lg:w-1/2 flex items-center justify-center p-8">
        <div className="w-full max-w-md">
          <div className="text-center mb-8">
            <h2 className="text-3xl font-bold text-gray-800">歡迎回來</h2>
            <p className="text-gray-500 mt-2">登入您的帳號繼續</p>
          </div>

          {error && (
            <div className="bg-red-50 border border-red-200 text-red-600 px-4 py-3 rounded-xl mb-6">
              {error}
            </div>
          )}

          <form onSubmit={handleSubmit} className="space-y-6">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Email
              </label>
              <input
                type="email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
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
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                className="input-field"
                placeholder="••••••••"
                required
              />
            </div>

            <button
              type="submit"
              disabled={loading}
              className="btn-primary w-full disabled:opacity-50"
            >
              {loading ? '登入中...' : '登入'}
            </button>
          </form>

          <p className="mt-8 text-center text-gray-500">
            還沒有帳號？{' '}
            <Link to="/register" className="text-green-600 font-medium hover:underline">
              立即註冊
            </Link>
          </p>
        </div>
      </div>
    </div>
  );
}
