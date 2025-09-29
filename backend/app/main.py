# app/main.py

from fastapi import FastAPI
from app.db import database
from app.api.v1.api import api_router

# Tạo các bảng trong database (nếu chúng chưa tồn tại)
database.Base.metadata.create_all(bind=database.engine)

app = FastAPI(
    title="Doctor AI API",
    description="Backend for Doctor AI Application",
    version="1.0.0"
)

# Include router của API v1
app.include_router(api_router, prefix="/api/v1")

@app.get("/", tags=["Root"])
def read_root():
    return {"message": "Welcome to Doctor AI API!"}