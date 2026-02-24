import React, { useState, useEffect } from 'react';

export default function Ingredients() {
  const [ingredients, setIngredients] = useState([]);
  const [loading, setLoading] = useState(true);
  const [showModal, setShowModal] = useState(false);
  const [formData, setFormData] = useState({
    name: '',
    category: '',
    unit: 'kg',
    unit_cost: ''
  });

  const token = localStorage.getItem('token');

  useEffect(() => {
    fetchIngredients();
  }, []);

  const fetchIngredients = async () => {
    try {
      const res = await fetch('/api/v1/ingredients', {
        headers: { 'Authorization': `Bearer ${token}` }
      });
      const data = await res.json();
      if (res.ok) {
        setIngredients(data.data || []);
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
      const res = await fetch('/api/v1/ingredients', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`
        },
        body: JSON.stringify({
          ...formData,
          unit_cost: parseFloat(formData.unit_cost)
        })
      });

      if (res.ok) {
        fetchIngredients();
        setShowModal(false);
        setFormData({ name: '', category: '', unit: 'kg', unit_cost: '' });
      }
    } catch (err) {
      console.error(err);
    }
  };

  const units = ['kg', 'g', 'L', 'mL', '個', '包'];
  const categories = ['茶葉', '糖類', '奶類', '配料', '水果', '其他'];

  return (
    <div className="p-8">
      <div className="flex items-center justify-between mb-8">
        <div>
          <h1 className="text-3xl font-bold text-gray-800">🫘 原物料管理</h1>
          <p className="text-gray-500 mt-1">管理原物料成本</p>
        </div>
        <button onClick={() => setShowModal(true)} className="btn-primary">
          + 新增原物料
        </button>
      </div>

      {/* 原物料列表 */}
      <div className="bg-white rounded-2xl shadow-sm overflow-hidden">
        <table className="w-full">
          <thead className="bg-gray-50">
            <tr>
              <th className="text-left px-6 py-4 font-medium text-gray-600">名稱</th>
              <th className="text-left px-6 py-4 font-medium text-gray-600">分類</th>
              <th className="text-left px-6 py-4 font-medium text-gray-600">單位</th>
              <th className="text-left px-6 py-4 font-medium text-gray-600">單位成本</th>
              <th className="text-left px-6 py-4 font-medium text-gray-600">操作</th>
            </tr>
          </thead>
          <tbody>
            {ingredients.map((item) => (
              <tr key={item.id} className="border-t hover:bg-gray-50">
                <td className="px-6 py-4 font-medium">{item.name}</td>
                <td className="px-6 py-4 text-gray-500">{item.category || '-'}</td>
                <td className="px-6 py-4 text-gray-500">{item.unit}</td>
                <td className="px-6 py-4 text-green-600 font-medium">${item.unit_cost}</td>
                <td className="px-6 py-4">
                  <button className="text-gray-400 hover:text-gray-600">編輯</button>
                </td>
              </tr>
            ))}
            {ingredients.length === 0 && (
              <tr>
                <td colSpan="5" className="px-6 py-12 text-center text-gray-400">
                  還沒有任何原物料
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>

      {/* Modal */}
      {showModal && (
        <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50">
          <div className="bg-white rounded-2xl p-6 w-full max-w-md">
            <h2 className="text-xl font-bold mb-6">新增原物料</h2>
            <form onSubmit={handleSubmit} className="space-y-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">名稱</label>
                <input
                  type="text"
                  value={formData.name}
                  onChange={(e) => setFormData({...formData, name: e.target.value})}
                  className="input-field"
                  required
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">分類</label>
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

              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">單位</label>
                  <select
                    value={formData.unit}
                    onChange={(e) => setFormData({...formData, unit: e.target.value})}
                    className="input-field"
                  >
                    {units.map((u) => (
                      <option key={u} value={u}>{u}</option>
                    ))}
                  </select>
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">單位成本</label>
                  <input
                    type="number"
                    value={formData.unit_cost}
                    onChange={(e) => setFormData({...formData, unit_cost: e.target.value})}
                    className="input-field"
                    required
                    min="0"
                    step="0.01"
                  />
                </div>
              </div>

              <div className="flex gap-3">
                <button type="submit" className="btn-primary flex-1">新增</button>
                <button type="button" onClick={() => setShowModal(false)} className="btn-secondary flex-1">取消</button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}
