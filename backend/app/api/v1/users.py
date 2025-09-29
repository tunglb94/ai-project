# clone/backend/app/api/v1/users.py

from fastapi import APIRouter

# Xóa tất cả các import không cần thiết liên quan đến user_schema, security, v.v.
# from fastapi import Depends, HTTPException, status
# from fastapi.security import OAuth2PasswordRequestForm
# from sqlalchemy.orm import Session
# from app.db import database
# from app.db.schemas import user_schema # Xóa dòng này
# from app.services import user_service
# from app.core import security
# from google.oauth2 import id_token
# from google.auth.transport import requests

router = APIRouter()

# Toàn bộ các endpoint /register, /login, /google-login đã được comment out hoặc xóa.
# File này giờ chỉ còn khai báo router và không có endpoint nào.