from sqlalchemy.orm import declarative_base,relationship
from sqlalchemy import Boolean,Column,Integer,String,ForeignKey,TIMESTAMP
from datetime import datetime

Base = declarative_base()

class User(Base):
    __tablename__="USER"
    
    primaryKey = Column(Integer,primary_key=True,index=True,nullable=False)
    email = Column(String(45),nullable=False)
    password = Column(String(120),nullable=False)
    name = Column(String(45),nullable=False)
    createdAt = Column(TIMESTAMP,default=datetime.utcnow)
    lastLogin = Column(TIMESTAMP)
    token = Column(String(256))
    