# clone/backend/app/api/v1/ai_assistant.py

from fastapi import APIRouter, Depends, HTTPException
import base64
from app.db.schemas import ai_schema
from app.services import ai_service
# from app.core.security import get_current_user # không còn cần import này

router = APIRouter()

@router.post("/chat", response_model=ai_schema.ChatResponse)
def handle_chat_query(request: ai_schema.ChatRequest):
    if not request.query or not request.query.strip():
        raise HTTPException(status_code=400, detail="Query cannot be empty.")
    response_text = ai_service.get_ai_chat_response(query=request.query)
    return {"answer": response_text}

@router.post("/voice-chat", response_model=ai_schema.VoiceChatResponse)
async def handle_voice_chat(request: ai_schema.VoiceChatRequest):
    try:
        audio_bytes = base64.b64decode(request.audio_content)
    except Exception:
        raise HTTPException(status_code=400, detail="Invalid base64 encoded audio content.")

    user_query_text = ai_service.convert_speech_to_text(
        audio_content=audio_bytes,
        audio_format=request.audio_format,
        sample_rate_hertz=request.sample_rate_hertz,
        language_code=request.language_code
    )

    if not user_query_text.strip():
        raise HTTPException(status_code=400, detail="Could not transcribe audio. Query is empty.")

    ai_text_response = ai_service.get_ai_chat_response(query=user_query_text)

    ai_audio_response_bytes = ai_service.convert_text_to_speech(
        text=ai_text_response,
        language_code=request.language_code,
        audio_format=request.audio_format
    )

    ai_audio_response_base64 = base64.b64encode(ai_audio_response_bytes).decode('utf-8')

    return {
        "text_response": ai_text_response,
        "audio_response": ai_audio_response_base64,
        "audio_format": request.audio_format
    }

@router.post("/analyze-lab-result", response_model=ai_schema.LabResultResponse)
async def handle_lab_result_upload(request: ai_schema.AnalyzeLabResultRequest):
    try:
        image_bytes = base64.b64decode(request.file)
    except Exception:
        raise HTTPException(status_code=400, detail="Invalid base64 encoded file.")

    if not request.file_type.startswith("image/") and not request.file_type == "application/pdf":
        raise HTTPException(status_code=400, detail="File provided is not an image or PDF.")
    
    analysis_result = ai_service.analyze_lab_result_image(
        image_bytes=image_bytes,
        file_type=request.file_type,
        test_type=request.test_type
    )
    return analysis_result

@router.post("/analyze-symptoms", response_model=ai_schema.SymptomResponse)
def handle_symptom_analysis(
    request: ai_schema.SymptomAnalysisRequest,
):
    """
    Handles a user's structured symptom data for analysis.
    """
    if not request.symptoms_description or not request.symptoms_description.strip():
        raise HTTPException(status_code=400, detail="Symptom description cannot be empty.")

    analysis_result = ai_service.analyze_symptoms(request_data=request.dict())

    return analysis_result

# NEW: Endpoint for Prescription Generation
@router.post("/generate-prescription", response_model=ai_schema.PrescriptionResponse)
async def generate_prescription(request: ai_schema.PrescriptionRequest):
    """
    Generates a prescription based on detailed patient and diagnosis information.
    """
    if not request.diagnosis.strip():
        raise HTTPException(status_code=400, detail="Diagnosis cannot be empty for prescription generation.")
    
    prescription_result = ai_service.generate_prescription(request_data=request.dict())
    return prescription_result