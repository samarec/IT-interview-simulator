from datetime import timedelta
from typing import Annotated

from app.api.routes.deps import get_db
from app.core import config
from app.domain.models import User
from app.domain.schemas import Token, UserCreate, UserLogin, UserOut
from app.services.auth_service import (
    authenticate_user,
    create_access_token,
    register_user,
)
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session

router = APIRouter(prefix="/auth", tags=["auth"])

# тип-зависимость для сессии БД
DbSession = Annotated[Session, Depends(get_db)]

@router.post("/register", response_model=UserOut, status_code=status.HTTP_201_CREATED)
def register(user_data: UserCreate, db: DbSession):
    existing_email = db.query(User).filter(User.email == user_data.email).first()
    if existing_email:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Email already registered"
        )
    existing_username = db.query(User).filter(User.username == user_data.username).first()
    if existing_username:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Username already taken"
        )
    
    return register_user(db, user_data)

@router.post("/login", response_model=Token)
def login(user_data: UserLogin, db: DbSession):
    user = authenticate_user(db, user_data.email, user_data.password)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect email or password",
            headers={"WWW-Authenticate": "Bearer"},
        )

    access_token_expires = timedelta(minutes=config.ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = create_access_token(
        data={
            "sub": str(user.id),
            "email": user.email,
            "role_id": user.role_id
        },
        expires_delta=access_token_expires,
    )
    
    return {"access_token": access_token, "token_type": "bearer"}