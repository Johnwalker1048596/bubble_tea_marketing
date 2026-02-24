import React from 'react';
import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';
import Login from './pages/Login';
import Register from './pages/Register';
import Layout from './components/Layout';
import Dashboard from './pages/Dashboard';
import ContentGenerate from './pages/ContentGenerate';
import ContentHistory from './pages/ContentHistory';
import Settings from './pages/Settings';
import Products from './pages/Products';
import Ingredients from './pages/Ingredients';

function PrivateRoute({ children }) {
  const token = localStorage.getItem('token');
  return token ? children : <Navigate to="/login" />;
}

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/login" element={<Login />} />
        <Route path="/register" element={<Register />} />
        <Route path="/" element={
          <PrivateRoute>
            <Layout />
          </PrivateRoute>
        }>
          <Route index element={<Navigate to="/dashboard" />} />
          <Route path="dashboard" element={<Dashboard />} />
          <Route path="content/generate" element={<ContentGenerate />} />
          <Route path="content/history" element={<ContentHistory />} />
          <Route path="products" element={<Products />} />
          <Route path="ingredients" element={<Ingredients />} />
          <Route path="settings" element={<Settings />} />
        </Route>
      </Routes>
    </BrowserRouter>
  );
}

export default App;
