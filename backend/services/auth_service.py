"""認證服務"""
from models import User


class AuthService:
    """認證相關業務邏輯"""
    
    @staticmethod
    def authenticate(email: str, password: str) -> User | None:
        """驗證使用者"""
        user = User.query.filter_by(email=email, is_active=True).first()
        
        if user and user.check_password(password):
            user.update_last_login()
            return user
        
        return None
    
    @staticmethod
    def get_user_by_email(email: str) -> User | None:
        """透過 email 取得使用者"""
        return User.query.filter_by(email=email).first()
