# clone/backend/app/db/schemas/ai_schema.py

from pydantic import BaseModel, Field
from typing import Optional, List
from pydantic import BaseModel, Field
from typing import Optional, List

# --- Schemas for Chat ---
class ChatRequest(BaseModel):
    query: str

class ChatResponse(BaseModel):
    answer: str

# --- Schemas for Lab Result Analysis ---
class LabIndicator(BaseModel):
    indicator_name: str
    value: str
    unit: str
    reference_range: str
    interpretation: str
    explanation: str
    questions_for_doctor: List[str]

class LabResultResponse(BaseModel):
    summary: str
    overall_interpretation: Optional[str] = None
    abnormal_indicators: List[LabIndicator]
    normal_indicators_summary: Optional[str] = None
    health_insights: Optional[str] = None
    recommendations: Optional[List[str]] = None

class AnalyzeLabResultRequest(BaseModel):
    file: str
    file_type: str
    test_type: Optional[str] = None


# --- Schemas for Symptom Analysis ---
class SymptomAnalysisRequest(BaseModel):
    department: Optional[str] = None
    symptoms_description: str
    medical_history: Optional[str] = None
    family_history: Optional[str] = None
    current_medications: Optional[str] = None

class SymptomResponse(BaseModel):
    recommended_specialties: List[str]
    potential_info: str
    disclaimer: str

# --- Schemas for Voice Chat ---
class VoiceChatRequest(BaseModel):
    audio_content: str
    audio_format: str = "LINEAR16"
    sample_rate_hertz: int = 16000
    language_code: str = "vi-VN"

class VoiceChatResponse(BaseModel):
    text_response: str
    audio_response: str
    audio_format: str = "MP3"


# --- NEW: Schemas for Prescription Generation ---
class PrescriptionDrug(BaseModel):
    drug_name: str = Field(..., description="Tên thuốc (ví dụ: Paracetamol, Amoxicillin).")
    dosage: str = Field(..., description="Liều dùng (ví dụ: 500mg, 1 viên).")
    frequency: str = Field(..., description="Tần suất sử dụng (ví dụ: 2 lần/ngày, mỗi 8 giờ).")
    duration: str = Field(..., description="Thời gian điều trị (ví dụ: 5 ngày, đến khi hết triệu chứng).")
    notes: Optional[str] = Field(None, description="Ghi chú thêm về cách dùng hoặc lưu ý đặc biệt.")
    # NEW: Thêm trường estimated_price
    estimated_price: Optional[str] = Field(None, description="Ước tính giá tham khảo của thuốc tại Việt Nam (ví dụ: 5.000 VNĐ/vỉ).")

class PrescriptionRequest(BaseModel):
    diagnosis: str = Field(..., description="Chẩn đoán bệnh lý chính xác từ bác sĩ.")
    symptoms: Optional[str] = Field(None, description="Các triệu chứng hiện tại liên quan đến bệnh.")
    patient_age: Optional[int] = Field(None, description="Tuổi của bệnh nhân.")
    patient_weight: Optional[float] = Field(None, description="Cân nặng của bệnh nhân (kg).")
    allergies: Optional[List[str]] = Field(None, description="Danh sách các dị ứng của bệnh nhân.")
    medical_history: Optional[str] = Field(None, description="Tiền sử bệnh lý của bệnh nhân.")
    additional_notes: Optional[str] = Field(None, description="Các thông tin hoặc yêu cầu bổ sung.")

class PrescriptionResponse(BaseModel):
    prescription_summary: str = Field(..., description="Tóm tắt ngắn gọn về đơn thuốc.")
    drugs: List[PrescriptionDrug] = Field(..., description="Danh sách các loại thuốc được kê.")
    general_advice: Optional[str] = Field(None, description="Lời khuyên chung về việc sử dụng thuốc và chăm sóc sức khỏe.")
    disclaimer: str = Field(..., description="Tuyên bố từ chối trách nhiệm về đơn thuốc.")
    # NEW: Thêm disclaimer riêng cho giá
    price_disclaimer: Optional[str] = Field("Lưu ý: Giá thuốc chỉ mang tính chất tham khảo tại thời điểm hiện tại và có thể thay đổi tùy thuộc vào nhà cung cấp và địa điểm.", description="Tuyên bố từ chối trách nhiệm về tính chính xác của giá thuốc.")