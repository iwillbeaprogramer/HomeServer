import bcrypt
from datetime import datetime,timedelta
from jose import jwt

class UserService:
    ENCODING:str = "UTF-8"
    SECRET_KEY:str = "509ed3db6349ad9160278aa10f78c2458e54935720fade7db9a5d606f3bcfdf7"
    JWT_ALGORITHEM:str = "HS256"
    def hash_password(self,plain_password:str) -> str:
        hashed_password:bytes = bcrypt.hashpw(plain_password.encode(self.ENCODING),salt=bcrypt.gensalt())
        return hashed_password.decode(self.ENCODING)
    
    def verify_password(self,plain_password:str,hashed_password:str) -> bool:
        return bcrypt.checkpw(plain_password.encode(self.ENCODING),hashed_password.encode(self.ENCODING))
        
    def create_jwt(self,username:str) -> str:
        return jwt.encode({"sub":username,"exp":datetime.now()+timedelta(days=1)},self.SECRET_KEY,algorithm=self.JWT_ALGORITHEM)
    
    def decode_jwt(self,access_token:str):
        payload = jwt.decode(access_token,self.SECRET_KEY,algorithms=[self.JWT_ALGORITHEM])
        # 원래 여기에 만료 확인
        return payload["sub"] # 이건 유저네임