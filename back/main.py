from fastapi import FastAPI,Request
from loguru import logger
from aiohttp import ClientSession
from contextlib import asynccontextmanager
from fastapi.middleware.cors import CORSMiddleware
from utils import request_parse,response_parse,make_log
from apis.login import loginRouter
@asynccontextmanager
async def lifespan(app:FastAPI):
    logger.add("log/{time:YYYY-MM-DD}.log",format="<green>{time:YYYY-MM-DD HH:mm:ss}</green>\n<blue>{message}</blue>\n",rotation="1 days",enqueue=True)
    yield

app = FastAPI(
    lifespan=lifespan
)

app.include_router(loginRouter)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.middleware("http")
async def watch_log(request:Request,call_next):
    start_log,start_time = await request_parse(request)
    response = await call_next(request)
    end_log,end_time = await response_parse(response)
    log = make_log(start_log,end_log,start_time,end_time)
    logger.info(log,)
    return response









if __name__=="__main__":
    import uvicorn
    uvicorn.run("main:app",reload=True)