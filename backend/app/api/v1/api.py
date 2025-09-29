# app/api/v1/api.py

from fastapi import APIRouter
# Xóa import users vì không còn sử dụng router người dùng
# from app.api.v1 import users, ai_assistant
from app.api.v1 import ai_assistant # CHỈ GIỮ LẠI AI ASSISTANT

api_router = APIRouter()

# Dòng này đã được comment out ở bước trước, giữ nguyên hoặc xóa
# api_router.include_router(users.router, prefix="/users", tags=["users"])
api_router.include_router(ai_assistant.router, prefix="/ai", tags=["ai_assistant"])