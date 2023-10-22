from sqlalchemy.ext.asyncio import create_async_engine,AsyncSession
from sqlalchemy.orm import sessionmaker
from sqlalchemy import select
from utils import DB_PORT,DB_HOST,DB_PASSWORD,DB_USER,SCHEMA

DATABASE_URL = f"mysql+aiomysql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{SCHEMA}"


engine = create_async_engine(DATABASE_URL,echo=False)
SessionFactory = sessionmaker(autocommit=False,autoflush=False,bind=engine,class_=AsyncSession)

async def get_db():
    session = SessionFactory()
    try:
        yield session
    finally:
        await session.close()