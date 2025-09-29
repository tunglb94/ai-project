# app/main.py
from fastapi import FastAPI
from app.db import database
from app.api.v1.api import api_router
from fastapi.middleware.cors import CORSMiddleware # <--- IMPORT MỚI

database.Base.metadata.create_all(bind=database.engine)

app = FastAPI(
    title="Doctor AI API",
    description="Backend for Doctor AI Application",
    version="1.0.0"
)

# Cấu hình CORS  <--- THÊM KHỐI NÀY
origins = ["*"]
app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(api_router, prefix="/api/v1")

@app.get("/", tags=["Root"])
def read_root():
    return {"message": "Welcome to Doctor AI API!"}