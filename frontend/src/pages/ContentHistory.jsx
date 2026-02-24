import React, { useState, useEffect } from 'react';

export default function ContentHistory() {
  const [contents, setContents] = useState([]);
  const [loading, setLoading] = useState(true);
  const [filter, setFilter] = useState('all');
  const [page, setPage] = useState(1);
  const [pagination, setPagination] = useState({ total: 0, total_pages: 1 });
  const [editingId, setEditingId] = useState(null);
  const [editText, setEditText] = useState('');

  const token = localStorage.getItem('token');

  useEffect(() => {
    fetchContents();
  }, [filter, page]);

  const fetchContents = async () => {
    setLoading(true);
    try {
      const status = filter === 'all' ? '' : `&status=${filter}`;
      const res = await fetch(`/api/v1/content?page=${page}&limit=10${status}`, {
        headers: { 'Authorization': `Bearer ${token}` }
      });
      const data = await res.json();
      if (res.ok) {
        setContents(data.data || []);
        setPagination(data.pagination || { total: 0, total_pages: 1 });
      }
    } catch (err) {
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  const handleEdit = (content) => {
    setEditingId(content.id);
    setEditText(content.generated_text);
  };

  const handleSaveEdit = async (contentId) => {
    try {
      const res = await fetch(`/api/v1/content/${contentId}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`
        },
        body: JSON.stringify({ generated_text: editText })
      });
      
      if (res.ok) {
        setEditingId(null);
        fetchContents();
      }
    } catch (err) {
      alert('儲存失敗');
    }
  };

  const handleDelete = async (contentId) => {
    if (!window.confirm('確定要刪除這篇貼文嗎？')) return;
    
    try {
      const res = await fetch(`/api/v1/content/${contentId}`, {
        method: 'DELETE',
        headers: { 'Authorization': `Bearer ${token}` }
      });
      
      if (res.ok) {
        fetchContents();
      }
    } catch (err) {
      alert('刪除失敗');
    }
  };

  const handlePublish = async (contentId) => {
    try {
      const res = await fetch(`/api/v1/content/${contentId}/publish`, {
        method: 'POST',
        headers: { 'Authorization': `Bearer ${token}` }
      });
      
      const data = await res.json();
      if (res.ok) {
        alert('發布成功！' + (data.note ? `\n\n${data.note}` : ''));
        fetchContents();
      }
    } catch (err) {
      alert('發布失敗');
    }
  };

  const statusColors = {
    draft: 'bg-gray-100 text-gray-600',
    pending: 'bg-yellow-100 text-yellow-700',
    approved: 'bg-blue-100 text-blue-700',
    published: 'bg-green-100 text-green-700',
    rejected: 'bg-red-100 text-red-700'
  };

  const statusLabels = {
    draft: '草稿',
    pending: '待審核',
    approved: '已核准',
    published: '已發布',
    rejected: '已拒絕'
  };

  return (
    <div className="p-8">
      <div className="flex items-center justify-between mb-8">
        <div>
          <h1 className="text-3xl font-bold text-gray-800">📋 歷史貼文</h1>
          <p className="text-gray-500 mt-1">管理所有生成的行銷內容</p>
        </div>
      </div>

      {/* 篩選器 */}
      <div className="flex gap-2 mb-6">
        {['all', 'draft', 'published'].map((f) => (
          <button
            key={f}
            onClick={() => { setFilter(f); setPage(1); }}
            className={`px-4 py-2 rounded-lg font-medium transition-all ${
              filter === f
                ? 'bg-green-500 text-white'
                : 'bg-white text-gray-600 hover:bg-gray-50'
            }`}
          >
            {f === 'all' ? '全部' : statusLabels[f]}
          </button>
        ))}
      </div>

      {/* 內容列表 */}
      {loading ? (
        <div className="text-center py-12 text-gray-400">載入中...</div>
      ) : contents.length === 0 ? (
        <div className="bg-white rounded-2xl p-12 text-center">
          <div className="text-5xl mb-4">📭</div>
          <p className="text-gray-500">還沒有任何內容</p>
          <a href="/content/generate" className="btn-primary inline-block mt-4">
            生成第一篇貼文
          </a>
        </div>
      ) : (
        <div className="space-y-4">
          {contents.map((content) => (
            <div key={content.id} className="bg-white rounded-2xl p-6 shadow-sm">
              <div className="flex items-start justify-between">
                <div className="flex-1">
                  <div className="flex items-center gap-3 mb-3">
                    <span className={`px-3 py-1 rounded-full text-xs font-medium ${statusColors[content.status]}`}>
                      {statusLabels[content.status]}
                    </span>
                    {content.product_name && (
                      <span className="text-sm text-gray-500">
                        🧋 {content.product_name}
                      </span>
                    )}
                    <span className="text-sm text-gray-400">
                      {new Date(content.created_at).toLocaleDateString('zh-TW')}
                    </span>
                  </div>
                  
                  {editingId === content.id ? (
                    <div className="space-y-3">
                      <textarea
                        value={editText}
                        onChange={(e) => setEditText(e.target.value)}
                        className="w-full p-3 border rounded-xl h-32 resize-none"
                      />
                      <div className="flex gap-2">
                        <button
                          onClick={() => handleSaveEdit(content.id)}
                          className="px-4 py-2 bg-green-500 text-white rounded-lg"
                        >
                          儲存
                        </button>
                        <button
                          onClick={() => setEditingId(null)}
                          className="px-4 py-2 bg-gray-200 rounded-lg"
                        >
                          取消
                        </button>
                      </div>
                    </div>
                  ) : (
                    <p className="text-gray-800 whitespace-pre-wrap">
                      {content.generated_text}
                    </p>
                  )}
                </div>
                
                {editingId !== content.id && (
                  <div className="flex gap-2 ml-4">
                    <button 
                      onClick={() => handleEdit(content)}
                      className="p-2 hover:bg-gray-100 rounded-lg transition-all"
                      title="編輯"
                    >
                      ✏️
                    </button>
                    {content.status !== 'published' && (
                      <button 
                        onClick={() => handlePublish(content.id)}
                        className="p-2 hover:bg-gray-100 rounded-lg transition-all"
                        title="發布"
                      >
                        📤
                      </button>
                    )}
                    <button 
                      onClick={() => handleDelete(content.id)}
                      className="p-2 hover:bg-red-100 rounded-lg transition-all text-red-500"
                      title="刪除"
                    >
                      🗑️
                    </button>
                  </div>
                )}
              </div>
            </div>
          ))}
        </div>
      )}

      {/* 分頁 */}
      {pagination.total_pages > 1 && (
        <div className="flex items-center justify-center gap-2 mt-8">
          <button
            onClick={() => setPage(p => Math.max(1, p - 1))}
            disabled={page === 1}
            className="px-4 py-2 rounded-lg bg-white disabled:opacity-50"
          >
            上一頁
          </button>
          <span className="px-4 py-2 text-gray-600">
            {page} / {pagination.total_pages}
          </span>
          <button
            onClick={() => setPage(p => Math.min(pagination.total_pages, p + 1))}
            disabled={page === pagination.total_pages}
            className="px-4 py-2 rounded-lg bg-white disabled:opacity-50"
          >
            下一頁
          </button>
        </div>
      )}
    </div>
  );
}
