from fastapi import APIRouter,Depends,HTTPException
from fastapi.encoders import jsonable_encoder
from .request import LoginRequest
from .repository import UserService
from .response import JWTResponse
from sqlalchemy.ext.asyncio import AsyncSession as Session
from sqlalchemy import select,update,insert,delete
from database import get_db,User

loginRouter = APIRouter(prefix="/login")


@loginRouter.post("",status_code=200)
async def login(request:LoginRequest,session:Session = Depends(get_db),userService:UserService = Depends(UserService)):
    email = request.email
    password = request.password
    query = select(User).where(User.email==email,User.password==password)
    db_result = await session.execute(query)
    result = db_result.one_or_none()
    if result is not None:
        user =  result[0]
        token = userService.create_jwt(user.name)
        query = update(User).where(User.primaryKey==user.primaryKey).values(token=token)
        await session.execute(query)
        await session.commit()
        return JWTResponse(access_token = token)
    raise HTTPException(status_code=400,detail="User or Password is not valid")

@loginRouter.get("",status_code=200)
async def user_list(session:Session = Depends(get_db)):
    query = select(User)
    db_result = await session.execute(query)
    result = db_result.all()
    result = [ jsonable_encoder(item[0]) for item in result]
    return result

