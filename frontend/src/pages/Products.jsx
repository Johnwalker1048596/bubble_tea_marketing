import React, { useState, useEffect } from 'react';

export default function Products() {
  const [products, setProducts] = useState([]);
  const [loading, setLoading] = useState(true);
  const [showModal, setShowModal] = useState(false);
  const [editingProduct, setEditingProduct] = useState(null);
  const [formData, setFormData] = useState({
    name: '',
    category: '',
    price: '',
    description: ''
  });

  const token = localStorage.getItem('token');

  useEffect(() => {
    fetchProducts();
  }, []);

  const fetchProducts = async () => {
    try {
      const res = await fetch('/api/v1/products', {
        headers: { 'Authorization': `Bearer ${token}` }
      });
      const data = await res.json();
      if (res.ok) {
        setProducts(data.data || []);
      }
    } catch (err) {
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const url = editingProduct
        ? `/api/v1/products/${editingProduct.id}`
        : '/api/v1/products';
      
      const res = await fetch(url, {
        method: editingProduct ? 'PUT' : 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`
        },
        body: JSON.stringify({
          ...formData,
          price: parseFloat(formData.price)
        })
      });

      if (res.ok) {
        fetchProducts();
        setShowModal(false);
        setFormData({ name: '', category: '', price: '', description: '' });
        setEditingProduct(null);
      }
    } catch (err) {
      console.error(err);
    }
  };

  const handleEdit = (product) => {
    setEditingProduct(product);
    setFormData({
      name: product.name,
      category: product.category || '',
      price: product.price,
      description: product.description || ''
    });
    setShowModal(true);
  };

  const categories = ['茶類', '奶茶', '果茶', '特調', '其他'];

  return (
    <div className="p-8">
      <div className="flex items-center justify-between mb-8">
        <div>
          <h1 className="text-3xl font-bold text-gray-800">🧋 產品管理</h1>
          <p className="text-gray-500 mt-1">管理您的飲品菜單</p>
        </div>
        <button
          onClick={() => { setShowModal(true); setEditingProduct(null); setFormData({ name: '', category: '', price: '', description: '' }); }}
          className="btn-primary"
        >
          + 新增產品
        </button>
      </div>

      {/* 產品列表 */}
      {loading ? (
        <div className="text-center py-12 text-gray-400">載入中...</div>
      ) : products.length === 0 ? (
        <div className="bg-white rounded-2xl p-12 text-center">
          <div className="text-5xl mb-4">🧋</div>
          <p className="text-gray-500 mb-4">還沒有任何產品</p>
          <button onClick={() => setShowModal(true)} className="btn-primary">
            新增第一個產品
          </button>
        </div>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {products.map((product) => (
            <div key={product.id} className="bg-white rounded-2xl p-6 shadow-sm card-hover">
              <div className="flex items-start justify-between mb-4">
                <div>
                  <h3 className="font-bold text-lg text-gray-800">{product.name}</h3>
                  {product.category && (
                    <span className="text-sm text-gray-500">{product.category}</span>
                  )}
                </div>
                <span className="text-xl font-bold text-green-600">
                  ${product.price}
                </span>
              </div>
              
              {product.cost && (
                <div className="flex items-center justify-between text-sm text-gray-500 mb-4">
                  <span>成本: ${product.cost}</span>
                  <span className="text-green-600">毛利: {Math.round(product.profit_margin * 100)}%</span>
                </div>
              )}

              <div className="flex gap-2">
                <button
                  onClick={() => handleEdit(product)}
                  className="flex-1 py-2 text-center bg-gray-100 hover:bg-gray-200 rounded-lg transition-all"
                >
                  編輯
                </button>
              </div>
            </div>
          ))}
        </div>
      )}

      {/* Modal */}
      {showModal && (
        <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50">
          <div className="bg-white rounded-2xl p-6 w-full max-w-md">
            <h2 className="text-xl font-bold mb-6">
              {editingProduct ? '編輯產品' : '新增產品'}
            </h2>
            <form onSubmit={handleSubmit} className="space-y-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  產品名稱
                </label>
                <input
                  type="text"
                  value={formData.name}
                  onChange={(e) => setFormData({...formData, name: e.target.value})}
                  className="input-field"
                  required
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  分類
                </label>
                <select
                  value={formData.category}
                  onChange={(e) => setFormData({...formData, category: e.target.value})}
                  className="input-field"
                >
                  <option value="">選擇分類</option>
                  {categories.map((c) => (
                    <option key={c} value={c}>{c}</option>
                  ))}
                </select>
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  售價
                </label>
                <input
                  type="number"
                  value={formData.price}
                  onChange={(e) => setFormData({...formData, price: e.target.value})}
                  className="input-field"
                  required
                  min="0"
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  描述
                </label>
                <textarea
                  value={formData.description}
                  onChange={(e) => setFormData({...formData, description: e.target.value})}
                  className="input-field h-20 resize-none"
                />
              </div>

              <div className="flex gap-3">
                <button type="submit" className="btn-primary flex-1">
                  {editingProduct ? '更新' : '新增'}
                </button>
                <button
                  type="button"
                  onClick={() => setShowModal(false)}
                  className="btn-secondary flex-1"
                >
                  取消
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}
