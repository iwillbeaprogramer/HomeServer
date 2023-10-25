from fastapi import Request,Depends,HTTPException
from fastapi.security import HTTPAuthorizationCredentials,HTTPBearer
from fastapi.encoders import jsonable_encoder
from starlette.concurrency import iterate_in_threadpool
from .configs import CARTOONPATH
import ujson
import time
import os




################################################################################
################################################################################
################################################################################
##############                                              #####################
##############     Cartoon 관련 API                         #####################
##############                                              ####################
################################################################################
################################################################################
################################################################################

async def getCartoonList():
    foldernames = os.listdir(CARTOONPATH)
    results = [
        {
            "title":foldername,
            "thumbnail_url":f"http://localhost:8000/cartoon/{foldername}/thumbnail",
        } for foldername in foldernames
    ]
    return results

def getThumbnailPath(title):
    folder_path = os.path.join(CARTOONPATH,title)
    images_list = os.listdir(folder_path)
    return os.path.join(folder_path,images_list[0])

def getContents(title):
    path = os.path.join(CARTOONPATH,title)
    imagesList = os.listdir(path)
    imagesList = [ [title,imageName] for imageName in imagesList] 
    return imagesList
    
def get_one_image(title,imageName):
    return os.path.join(CARTOONPATH,title,imageName)
################################################################################
################################################################################
################################################################################
##############                                              #####################
##############     Token Get하는 Method                     #####################
##############                                              ####################
################################################################################
################################################################################
################################################################################

def get_access_token(auth_header:HTTPAuthorizationCredentials | None = Depends(HTTPBearer(auto_error=False)))->str:
    if auth_header is None:
        raise HTTPException(status_code=401,detail="Not Authorized")
    return auth_header.credentials





################################################################################
################################################################################
################################################################################
##############                                              #####################
##############     Middleware 에서 로그 관리하는 API         #####################
##############                                              ####################
################################################################################
################################################################################
################################################################################

def make_log(start_log,end_log,start_time,end_time):
    return start_log+"\n"+end_log+f"\n\t처리시간 : {str(end_time-start_time)[:7]}"

async def set_body(request: Request, body: bytes):
    async def receive():
        return {'type': 'http.request', 'body': body}
    request._receive = receive


async def request_parse(request:Request):
    req_body = await request.body()
    await set_body(request, req_body)
    try:
        body = ujson.loads(jsonable_encoder(req_body))
        body_string = "\n".join([ f"\t\t{key} : {body[key]}" for key in body])
    except:
        body_string = ""
    return f"\tMethod : {request.method}\n\t여기에서 : {request.client.host}:{request.client.port}\n\t여기로 : {request.url}\n\t요청JSON : \n{body_string}",time.time()

async def response_parse(response):
    response_body = [chunk async for chunk in response.body_iterator]
    response.body_iterator = iterate_in_threadpool(iter(response_body))
    try:
        body = ujson.loads(response_body[0].decode())
        body_string = "\n".join([ f"\t\t{key} : {body[key]}" for key in body])
    except:
        body_string=""
    if not hasattr(response.headers,"content-type"):
        content_type="else"
    else:
        content_type=response.headers["content-type"]
    return f"\t응답코드 : {response.status_code}\n\t결과타입 : {content_type}\n\t결과JSON : \n{body_string}",time.time()
