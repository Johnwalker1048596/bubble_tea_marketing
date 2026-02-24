"""
RAG 服務 - 菜單知識庫
使用 Qdrant + OpenAI Embeddings
"""
import os
from typing import List, Dict, Optional


class RAGService:
    """
    RAG (Retrieval-Augmented Generation) 服務
    負責管理菜單知識庫，提供相似產品搜尋
    """

    def __init__(self):
        self.use_openai_embedding = bool(os.getenv('OPENAI_API_KEY'))
        self.client = None
        self.collection_name = "menu_knowledge"
        self._init_db()

    def _init_db(self):
        """初始化 Qdrant 向量資料庫"""
        try:
            from qdrant_client import QdrantClient
            from qdrant_client.models import Distance, VectorParams

            host = os.getenv('QDRANT_HOST', 'localhost')
            port = int(os.getenv('QDRANT_PORT', 6333))

            self.client = QdrantClient(host=host, port=port)

            # 檢查 collection 是否存在
            collections = self.client.get_collections().collections
            collection_names = [c.name for c in collections]

            if self.collection_name not in collection_names:
                # 建立 collection（1536 維度對應 OpenAI text-embedding-3-small）
                self.client.create_collection(
                    collection_name=self.collection_name,
                    vectors_config=VectorParams(size=1536, distance=Distance.COSINE)
                )

            print(f"✅ Qdrant 初始化成功，OpenAI Embedding: {self.use_openai_embedding}")

        except Exception as e:
            print(f"⚠️ Qdrant 初始化失敗: {e}")
            self.client = None

    def _get_embedding(self, text: str) -> List[float]:
        """取得文字的 embedding 向量"""
        if not self.use_openai_embedding:
            # 無 API Key 時返回假向量
            import hashlib
            hash_val = int(hashlib.md5(text.encode()).hexdigest(), 16)
            return [(hash_val >> i & 1) * 0.1 - 0.05 for i in range(1536)]

        try:
            from openai import OpenAI
            client = OpenAI(api_key=os.getenv('OPENAI_API_KEY'))
            response = client.embeddings.create(
                input=text,
                model="text-embedding-3-small"
            )
            return response.data[0].embedding
        except Exception as e:
            print(f"⚠️ Embedding 失敗: {e}")
            return [0.0] * 1536

    def add_product(self, product_id: str, name: str, description: str,
                    category: str, price: float = None) -> bool:
        """將產品加入知識庫"""
        if not self.client:
            return False

        try:
            from qdrant_client.models import PointStruct

            # 建構文檔內容
            doc_parts = [f"產品名稱：{name}"]
            if description:
                doc_parts.append(f"描述：{description}")
            if category:
                doc_parts.append(f"分類：{category}")
            if price:
                doc_parts.append(f"售價：{price}元")

            document = "。".join(doc_parts)
            embedding = self._get_embedding(document)

            # 使用 product_id 的 hash 作為數字 ID
            point_id = abs(hash(product_id)) % (10 ** 12)

            point = PointStruct(
                id=point_id,
                vector=embedding,
                payload={
                    "product_id": product_id,
                    "name": name,
                    "category": category or "",
                    "price": str(price) if price else "",
                    "document": document
                }
            )

            self.client.upsert(
                collection_name=self.collection_name,
                points=[point]
            )

            return True

        except Exception as e:
            print(f"❌ 加入產品失敗: {e}")
            return False

    def remove_product(self, product_id: str) -> bool:
        """從知識庫移除產品"""
        if not self.client:
            return False

        try:
            from qdrant_client.models import Filter, FieldCondition, MatchValue

            self.client.delete(
                collection_name=self.collection_name,
                points_selector=Filter(
                    must=[FieldCondition(key="product_id", match=MatchValue(value=product_id))]
                )
            )
            return True
        except Exception as e:
            print(f"❌ 移除產品失敗: {e}")
            return False

    def search_similar(self, query: str, n_results: int = 5) -> Dict:
        """搜尋相似產品"""
        if not self.client:
            return self._fallback_search(query)

        try:
            embedding = self._get_embedding(query)

            results = self.client.search(
                collection_name=self.collection_name,
                query_vector=embedding,
                limit=n_results
            )

            if not results:
                return self._fallback_search(query)

            documents = []
            metadatas = []

            for hit in results:
                payload = hit.payload
                documents.append(payload.get('document', ''))
                metadatas.append({
                    'name': payload.get('name', ''),
                    'category': payload.get('category', ''),
                    'price': payload.get('price', '')
                })

            return {
                'documents': [documents],
                'metadatas': [metadatas]
            }

        except Exception as e:
            print(f"⚠️ 搜尋失敗: {e}")
            return self._fallback_search(query)

    def get_context_for_generation(self, product_name: str = None,
                                    category: str = None,
                                    weather: str = None) -> str:
        """取得 AI 生成用的上下文"""
        context_parts = []

        if product_name or category:
            query = product_name or category
            results = self.search_similar(query, n_results=3)

            if results and results.get('documents', [[]])[0]:
                context_parts.append("【相關產品資訊】")
                for i, doc in enumerate(results['documents'][0], 1):
                    context_parts.append(f"{i}. {doc}")

        if weather:
            context_parts.append(f"\n【天氣情境】\n{weather}")

        if not context_parts:
            return self._get_default_context()

        return "\n".join(context_parts)

    def get_low_cost_products(self, limit: int = 5) -> List[Dict]:
        """取得低成本產品推薦"""
        if not self.client:
            return []

        try:
            # 取得所有產品
            results = self.client.scroll(
                collection_name=self.collection_name,
                limit=100
            )

            products_with_price = []
            for point in results[0]:
                payload = point.payload
                if payload.get('price'):
                    try:
                        price = float(payload['price'])
                        products_with_price.append({
                            'id': payload.get('product_id', ''),
                            'name': payload.get('name', ''),
                            'category': payload.get('category', ''),
                            'price': price
                        })
                    except:
                        pass

            products_with_price.sort(key=lambda x: x['price'])
            return products_with_price[:limit]

        except Exception as e:
            print(f"⚠️ 取得低成本產品失敗: {e}")
            return []

    def rebuild_index(self, products: List[Dict]) -> int:
        """重建整個知識庫索引"""
        if not self.client:
            return 0

        try:
            from qdrant_client.models import Distance, VectorParams

            # 刪除並重建 collection
            self.client.delete_collection(self.collection_name)
            self.client.create_collection(
                collection_name=self.collection_name,
                vectors_config=VectorParams(size=1536, distance=Distance.COSINE)
            )

            # 批次加入
            success_count = 0
            for product in products:
                if self.add_product(
                    product_id=str(product.get('id')),
                    name=product.get('name', ''),
                    description=product.get('description', ''),
                    category=product.get('category', ''),
                    price=product.get('price')
                ):
                    success_count += 1

            return success_count

        except Exception as e:
            print(f"❌ 重建索引失敗: {e}")
            return 0

    def _fallback_search(self, query: str) -> Dict:
        """備用搜尋"""
        return {
            'documents': [[
                '珍珠奶茶 - 經典不敗的國民飲料，Q彈珍珠配上香濃奶茶',
                '四季春茶 - 清香回甘的經典茶品，適合各種天氣',
                '黑糖珍珠鮮奶 - 手炒黑糖香氣濃郁，珍珠Q彈有嚼勁'
            ]],
            'metadatas': [[
                {'name': '珍珠奶茶', 'category': '奶茶類'},
                {'name': '四季春茶', 'category': '茶類'},
                {'name': '黑糖珍珠鮮奶', 'category': '鮮奶類'}
            ]]
        }

    def _get_default_context(self) -> str:
        """預設上下文"""
        return """【相關產品資訊】
1. 珍珠奶茶：經典國民飲料，Q彈珍珠配上香濃奶茶，百喝不膩
2. 波霸奶茶：大顆波霸口感更有嚼勁，奶茶控必點
3. 四季春茶：清香回甘的經典茶品，茶香撲鼻
4. 黑糖珍珠鮮奶：手炒黑糖香氣濃郁，虎紋漸層超好拍
5. 芋頭鮮奶：綿密芋泥搭配鮮奶，芋頭控最愛"""
