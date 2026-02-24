# 🧋 飲料店行銷助手

AI 驅動的飲料店社群行銷內容生成系統

## 功能特色

- 🤖 AI 文案生成 (LangChain)
- 🎨 AI 圖片生成 (NanoBanana API)
- ☀️ 天氣情境整合
- 📈 趨勢分析
- 📱 Instagram 一鍵發布
- 💰 成本管理與低成本推薦

## 快速開始

```bash
# 1. 複製環境變數
cp .env.example .env

# 2. 啟動所有服務
docker-compose up -d

# 3. 執行資料庫遷移
docker-compose exec api flask db upgrade

# 4. 訪問應用
# Frontend: http://localhost:3000
# API: http://localhost:5000
# MinIO Console: http://localhost:9001

***

## Part 2：Backend 核心檔案

```bash
# ============================================
# 2. Backend 核心檔案
# ============================================

cd ~/bubble_tea_marketing

# backend/Dockerfile
cat > backend/Dockerfile << 'EOF'
FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV FLASK_APP=app.py
ENV FLASK_ENV=development

EXPOSE 5000

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--reload", "app:create_app()"]
