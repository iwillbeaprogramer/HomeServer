from fastapi import APIRouter,Depends,Path,Query
from fastapi.responses import FileResponse
from utils import get_access_token,getCartoonList,getThumbnailPath,getContents,get_one_image
import os

cartoonRouter = APIRouter(prefix="/cartoon")



@cartoonRouter.get("/",status_code=200)
# async def get(access_token:str = Depends(get_access_token)):
async def get():
    """
    [
        {
            "thumbnail_url":~,
            "title":~
        },
    ]
    """
    return await getCartoonList()


@cartoonRouter.get("/{name}/thumbnail",status_code=200)
# async def getThumbnail(access_token:str = Depends(get_access_token),name:str=Path(...)):
async def get_Thumbnail(name:str=Path(...)):
    path = getThumbnailPath(name)
    return FileResponse(path)

@cartoonRouter.get("/{title}/contents")
async def get_Contents(title:str=Path(...)):
    """
    [
        image_path1,image_path2,....
    ]
    """
    return getContents(title)

@cartoonRouter.get("/{title}/contents/{imageName}")
async def get_Contents_Image(title:str=Path(...),imageName:str=Path(...)):
    print("!!!!!!!!!!!!!!!!!!!!!")
    print("!!!!!!!!!!!!!!!!!!!!!")
    print("!!!!!!!!!!!!!!!!!!!!!")
    print("!!!!!!!!!!!!!!!!!!!!!")
    print("!!!!!!!!!!!!!!!!!!!!!")
    return FileResponse(get_one_image(title,imageName))


