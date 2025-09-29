# clone/backend/app/services/ai_service.py

import google.generativeai as genai
from app.core.config import settings
from PIL import Image
import io
import json
from typing import Dict, List, Optional
from fastapi import HTTPException
from app.db.schemas import ai_schema
import base64

# Google Cloud Imports (đã comment out để không cố gắng import nếu không cần thiết)
# from google.cloud import speech_v1p1beta1 as speech
# from google.cloud import texttospeech_v1 as texttospeech

# Khởi tạo clients cho Google Cloud Speech-to-Text và Text-to-Speech
speech_client = None
tts_client = None

# Khởi tạo model AI khi ứng dụng khởi động
model = None
try:
    genai.configure(api_key=settings.GOOGLE_API_KEY)
    
    # SỬA LẠI TÊN MODEL THÀNH PHIÊN BẢN TƯƠNG THÍCH NHẤT
    model = genai.GenerativeModel('gemini-1.0-pro')
    
    # In ra xác nhận nếu model được khởi tạo thành công
    if model:
        print("INFO: Mô hình Gemini AI đã được cấu hình thành công với 'gemini-1.0-pro'.")
    
except Exception as e:
    # In ra lỗi cụ thể từ Gemini API hoặc quá trình cấu hình
    print(f"LỖI CẤU HÌNH AI: Mô hình Gemini AI không thể khởi tạo. Vấn đề: {e}")
    model = None # Đảm bảo model là None nếu có lỗi

def get_ai_chat_response(query: str) -> str:
    # Kiểm tra xem mô hình AI đã được cấu hình thành công hay chưa
    if model is None: 
        print("LỖI: Gọi AI Chat khi model chưa được cấu hình.")
        return "Lỗi: Dịch vụ AI chưa được cấu hình đúng. Vui lòng kiểm tra GOOGLE_API_KEY và log backend."
    
    prompt = f"Bạn là một trợ lý y tế AI tên là Doctor AI. Nhiệm vụ của bạn là cung cấp thông tin tham khảo, dễ hiểu từ các kiến thức y khoa phổ thông. Người dùng hỏi: \"{query}\". Câu trả lời của bạn:"
    try:
        response = model.generate_content(prompt)
        disclaimer = "\n\n---Lưu ý: Thông tin này chỉ mang tính chất tham khảo, không thay thế cho việc chẩn đoán và tư vấn của bác sĩ chuyên khoa."
        return response.text + disclaimer
    except Exception as e:
        print(f"LỖI GỌI API GEMINI (Chat): {e}")
        return "Xin lỗi, đã có lỗi xảy ra trong quá trình xử lý yêu cầu của bạn. Vui lòng thử lại sau."

def convert_speech_to_text(audio_content: bytes, audio_format: str, sample_rate_hertz: int, language_code: str) -> str:
    # Chức năng này đã bị vô hiệu hóa
    raise HTTPException(status_code=501, detail="Speech-to-Text service is not configured. Please enable Google Cloud credentials if you need this feature.")

def convert_text_to_speech(text: str, language_code: str = "vi-VN", audio_format: str = "MP3") -> bytes:
    # Chức năng này đã bị vô hiệu hóa
    raise HTTPException(status_code=501, detail="Text-to-Speech service is not configured. Please enable Google Cloud credentials if you need this feature.")


def analyze_lab_result_image(image_bytes: bytes, file_type: str, test_type: Optional[str] = None) -> Dict:
    # Kiểm tra xem mô hình AI đã được cấu hình thành công hay chưa
    if model is None:
        print("LỖI: Gọi AI Phân tích xét nghiệm khi model chưa được cấu hình.")
        return {
            "summary": "Lỗi: Dịch vụ AI chưa được cấu hình đúng. Vui lòng kiểm tra GOOGLE_API_KEY và log backend.",
            "overall_interpretation": "",
            "abnormal_indicators": [],
            "normal_indicators_summary": "",
            "health_insights": "",
            "recommendations": []
        }

    input_content = None
    if file_type.startswith("image/"):
        try:
            img = Image.open(io.BytesIO(image_bytes))
            input_content = img
        except Exception as e:
            print(f"Error opening image: {e}")
            raise HTTPException(status_code=400, detail="Could not process image file.")
    elif file_type == "application/pdf":
        print("PDF analysis is complex and requires additional libraries (e.g., PyPDF2, pdfminer.six).")
        print("For now, only image analysis is fully supported with direct content input to Gemini Vision model.")
        raise HTTPException(status_code=501, detail="PDF analysis is not yet fully implemented. Please upload an image or describe the results.")
    else:
        raise HTTPException(status_code=400, detail="Unsupported file type. Please upload an image or PDF.")

    prompt_parts = [
        "Bạn là một trợ lý y tế AI tên là Doctor AI, chuyên phân tích kết quả xét nghiệm, X-quang, MRI, hoặc các tài liệu y tế có chỉ số.",
        "Hãy phân tích chi tiết hình ảnh hoặc nội dung tài liệu y tế này. "
    ]
    
    if test_type:
        prompt_parts.append(f"Đây là kết quả của loại tài liệu/xét nghiệm: {test_type}. ")
    else:
        prompt_parts.append("Vui lòng tự nhận diện loại tài liệu y tế (ví dụ: Xét nghiệm máu, X-Quang, MRI, Xét nghiệm nước tiểu, Đơn thuốc, v.v.) và phân tích dựa trên đó. ")

    prompt_parts.extend([
        "Kết quả trả về phải là một đối tượng JSON với các trường sau:",
        "1. 'summary': Một đoạn tóm tắt tổng quan ngắn gọn về tình trạng sức khỏe dựa trên kết quả.",
        "2. 'overall_interpretation': Một đoạn diễn giải tổng thể, chi tiết hơn về ý nghĩa của toàn bộ kết quả xét nghiệm, các xu hướng và tác động tiềm ẩn đến sức khỏe.",
        "3. 'abnormal_indicators': Một danh sách (array) các đối tượng. Mỗi đối tượng đại diện cho một chỉ số bất thường được phát hiện. Nếu không có chỉ số bất thường, danh sách này sẽ rỗng.",
        "4. 'normal_indicators_summary': Một đoạn tóm tắt về các chỉ số nằm trong phạm vi bình thường, nếu có.",
        "5. 'health_insights': Thông tin chuyên sâu về sức khỏe dựa trên các chỉ số được phân tích, có thể bao gồm các yếu tố nguy cơ hoặc lời khuyên chung về lối sống.",
        "6. 'recommendations': Một danh sách các khuyến nghị cụ thể (ví dụ: cần tham khảo ý kiến bác sĩ, cần theo dõi thêm, thay đổi lối sống).",
        "",
        "Mỗi đối tượng trong 'abnormal_indicators' phải có các trường sau:",
        "   - 'indicator_name': Tên của chỉ số (ví dụ: 'Glucose', 'ALT', 'Creatinine').",
        "   - 'value': Giá trị cụ thể của chỉ số đó.",
        "   - 'unit': Đơn vị của chỉ số (ví dụ: 'mmol/L', 'U/L', 'mg/dL').",
        "   - 'reference_range': Phạm vi tham chiếu bình thường của chỉ số đó.",
        "   - 'interpretation': Giải thích ý nghĩa của chỉ số bất thường này đối với sức khỏe (ví dụ: 'Cao hơn mức bình thường').",
        "   - 'explanation': Giải thích chi tiết hơn về chỉ số, nguyên nhân có thể, và các triệu chứng liên quan (nếu có).",
        "   - 'questions_for_doctor': Một danh sách các câu hỏi mà bệnh nhân nên hỏi bác sĩ về chỉ số bất thường này.",
        "",
        "Nếu không có chỉ số bất thường nào, hãy cung cấp một tóm tắt tích cực về kết quả bình thường và danh sách 'abnormal_indicators' là rỗng.",
        "Đảm bảo rằng toàn bộ output là một JSON hợp lệ và không có bất kỳ văn bản nào khác ngoài JSON."
    ])

    contents = prompt_parts
    if input_content:
        contents = [input_content] + prompt_parts

    try:
        response = model.generate_content(contents, generation_config={"response_mime_type": "application/json"})
        raw_json_str = response.text.strip().replace("```json", "").replace("```", "")
        analysis_data = json.loads(raw_json_str)

        return ai_schema.LabResultResponse(
            summary=analysis_data.get("summary", "Không có tóm tắt."),
            overall_interpretation=analysis_data.get("overall_interpretation", "Không có diễn giải tổng thể."),
            abnormal_indicators=[
                ai_schema.LabIndicator(
                    indicator_name=item.get("indicator_name", "N/A"),
                    value=item.get("value", "N/A"),
                    unit=item.get("unit", "N/A"),
                    reference_range=item.get("reference_range", "N/A"),
                    interpretation=item.get("interpretation", "N/A"),
                    explanation=item.get("explanation", "N/A"),
                    questions_for_doctor=item.get("questions_for_doctor", [])
                ) for item in analysis_data.get("abnormal_indicators", []) if isinstance(item, dict)
            ],
            normal_indicators_summary=analysis_data.get("normal_indicators_summary", "Không có tóm tắt chỉ số bình thường."),
            health_insights=analysis_data.get("health_insights", "Không có thông tin chuyên sâu về sức khỏe."),
            recommendations=analysis_data.get("recommendations", [])
        ).dict()
    except json.JSONDecodeError as e:
        print(f"LỖI PHÂN TÍCH JSON TỪ AI (Lab Result): {e} - Phản hồi thô: {response.text}")
        raise HTTPException(status_code=500, detail="Lỗi phân tích kết quả từ AI. Định dạng phản hồi không hợp lệ.")
    except Exception as e:
        print(f"LỖI GỌI API GEMINI (Lab Result): {e}")
        raise HTTPException(status_code=500, detail=f"Đã có lỗi xảy ra trong quá trình phân tích: {e}")


def analyze_symptoms(request_data: dict) -> Dict:
    # Kiểm tra xem mô hình AI đã được cấu hình thành công hay chưa
    if model is None:
        print("LỖI: Gọi AI Phân tích triệu chứng khi model chưa được cấu hình.")
        return { "recommended_specialties": [], "potential_info": "Lỗi: Dịch vụ AI chưa được cấu hình đúng. Vui lòng kiểm tra GOOGLE_API_KEY và log backend.", "disclaimer": ""}

    prompt_parts = [
        "Bạn là một trợ lý y tế AI tên là Doctor AI. Nhiệm vụ của bạn là định hướng người dùng đến đúng chuyên khoa y tế dựa trên các thông tin họ cung cấp.",
        "Dựa trên các triệu chứng và thông tin bệnh sử được cung cấp, hãy đưa ra một phân tích chi tiết, toàn diện. Phần 'thông_tin_tiem_nang' cần phải thật dài, chi tiết và có cấu trúc mạch lạc, bao gồm các phần như mô tả về các bệnh lý tiềm ẩn, các yếu tố nguy hiểm, và các lời khuyên ban đầu về cách tự chăm sóc hoặc khi nào cần thăm khám bác sĩ. Đừng chỉ liệt kê các bệnh, mà hãy giải thích ngắn gọn từng khả năng."
    ]
    prompt_parts.append(f"Triệu chứng chính: {request_data.get('symptoms_description')}")
    if request_data.get('department'):
        prompt_parts.append(f"Khoa đã chọn (nếu có): {request_data.get('department')}")
    if request_data.get('medical_history'):
        prompt_parts.append(f"Bệnh sử cá nhân: {request_data.get('medical_history')}")
    if request_data.get('family_history'):
        prompt_parts.append(f"Tiền sử bệnh gia đình: {request_data.get('family_history')}")
    if request_data.get('current_medications'):
        prompt_parts.append(f"Thuốc đang sử dụng: {request_data.get('current_medications')}")

    prompt_parts.append("\nDựa vào các thông tin trên, hãy:")
    prompt_parts.append("1. Liệt kê 3-4 chuyên khoa y tế phù hợp nhất mà người dùng nên đến khám.")
    prompt_parts.append("2. Cung cấp một đoạn thông tin chi tiết (thật dài và có cấu trúc) về nhóm vấn đề mà các triệu chứng này CÓ THỂ liên quan. Phần này cần bao gồm: các bệnh lý tiềm ẩn có thể gây ra triệu chứng này (giải thích ngắn gọn từng bệnh), các yếu tố nguy hiểm, và các lời khuyên ban đầu về cách tự chăm sóc hoặc khi nào cần tìm kiếm sự chăm sóc y tế khẩn cấp.")
    prompt_parts.append('\nTrả về kết quả dưới dạng một object JSON với các key: "recommended_specialties" (một danh sách các chuỗi) và "potential_info" (một chuỗi).')


    final_prompt = "\n".join(prompt_parts)

    try:
        response = model.generate_content(final_prompt, generation_config={"response_mime_type": "application/json"})
        raw_json_str = response.text.strip().replace("```json", "").replace("```", "")
        analysis_data = json.loads(raw_json_str)

        return {
            "recommended_specialties": analysis_data.get("recommended_specialties", []),
            "potential_info": analysis_data.get("potential_info", "Không có thông tin thêm."),
            "disclaimer": "Gợi ý này chỉ mang tính tham khảo và không thể thay thế cho chẩn đoán của bác sĩ. Vui lòng đến cơ sở y tế để được thăm khám."
        }
    except json.JSONDecodeError as e:
        print(f"LỖI PHÂN TÍCH JSON TỪ AI (Symptom Analysis): {e} - Phản hồi thô: {response.text}")
        return { "recommended_specialties": [], "potential_info": "Lỗi phân tích kết quả. Định dạng phản hồi không hợp lệ.", "disclaimer": ""}
    except Exception as e:
        print(f"LỖI GỌI API GEMINI (Symptom Analysis): {e}")
        return { "recommended_specialties": [], "potential_info": "Đã có lỗi xảy ra trong quá trình phân tích.", "disclaimer": ""}

# Function to generate prescription
def generate_prescription(request_data: dict) -> Dict:
    # Kiểm tra xem mô hình AI đã được cấu hình thành công hay chưa
    if model is None:
        print("LỖI: Gọi AI Kê đơn khi model chưa được cấu hình.")
        return {
            "prescription_summary": "Lỗi: Dịch vụ AI chưa được cấu hình đúng. Vui lòng kiểm tra GOOGLE_API_KEY và log backend.",
            "drugs": [],
            "general_advice": "",
            "disclaimer": "Lưu ý: Đơn thuốc này chỉ mang tính chất tham khảo. Vui lòng tham khảo ý kiến bác sĩ hoặc dược sĩ trước khi sử dụng bất kỳ loại thuốc nào.",
            "price_disclaimer": "Lưu ý: Giá thuốc chỉ mang tính chất tham khảo tại thời điểm hiện tại và có thể thay đổi tùy thuộc vào nhà cung cấp và địa điểm."
        }

    # Xây dựng prompt chi tiết cho mô hình AI
    prompt_parts = [
        "Bạn là một trợ lý y tế AI tên là Doctor AI, chuyên hỗ trợ kê đơn thuốc dựa trên thông tin bệnh lý đã được bác sĩ chẩn đoán. Mục tiêu là cung cấp một đơn thuốc tham khảo, ưu tiên các loại thuốc phổ biến ở Việt Nam và **hạn chế kê thuốc kháng sinh** trừ khi thật sự cần thiết cho bệnh lý cụ thể.",
        "Thông tin bệnh nhân và chẩn đoán:",
        f"- Chẩn đoán: {request_data.get('diagnosis')}",
    ]

    if request_data.get('symptoms'):
        prompt_parts.append(f"- Triệu chứng: {request_data.get('symptoms')}")
    if request_data.get('patient_age'):
        prompt_parts.append(f"- Tuổi: {request_data.get('patient_age')} tuổi")
    if request_data.get('patient_weight'):
        prompt_parts.append(f"- Cân nặng: {request_data.get('patient_weight')} kg")
    if request_data.get('allergies') and len(request_data['allergies']) > 0:
        prompt_parts.append(f"- Dị ứng: {', '.join(request_data['allergies'])}")
    if request_data.get('medical_history'):
        prompt_parts.append(f"- Tiền sử bệnh: {request_data.get('medical_history')}")
    if request_data.get('additional_notes'):
        prompt_parts.append(f"- Ghi chú thêm: {request_data.get('additional_notes')}")

    prompt_parts.extend([
        "\nDựa trên thông tin trên, hãy kê một đơn thuốc tham khảo. Đơn thuốc phải tuân thủ các quy tắc sau:",
        "1. Ưu tiên các loại thuốc không cần kê đơn hoặc thuốc phổ biến, dễ mua ở Việt Nam.",
        "2. **Hạn chế tối đa kê thuốc kháng sinh**. Chỉ kê kháng sinh nếu chẩn đoán **rõ ràng** yêu cầu và đó là kháng sinh thông thường được sử dụng cho bệnh đó (ví dụ: viêm họng do vi khuẩn).",
        "3. Đơn thuốc phải bao gồm các thuốc giảm triệu chứng (hạ sốt, giảm đau, ho...) và hỗ trợ điều trị.",
        "4. Cung cấp liều dùng, tần suất, thời gian điều trị cụ thể và **ước tính giá tham khảo (bằng VNĐ) cho từng loại thuốc**. Giá nên là giá phổ biến cho một vỉ hoặc một hộp nhỏ, ghi rõ đơn vị (ví dụ: '5.000 VNĐ/vỉ' hoặc 'Khoảng 20.000 VNĐ/hộp').",
        "",
        "Kết quả trả về phải là một đối tượng JSON với các trường sau:",
        "   - 'prescription_summary': Một đoạn tóm tắt ngắn gọn về đơn thuốc, giải thích mục đích chính của các thuốc.",
        "   - 'drugs': Một danh sách (array) các đối tượng, mỗi đối tượng là một loại thuốc. Mỗi đối tượng thuốc phải có các trường: 'drug_name' (tên thuốc), 'dosage' (liều dùng), 'frequency' (tần suất), 'duration' (thời gian điều trị), 'notes' (ghi chú thêm, optional), và **'estimated_price' (giá tham khảo bằng VNĐ, optional)**.",
        "   - 'general_advice': Lời khuyên chung về việc sử dụng thuốc (ví dụ: uống với nước, sau ăn) và các lời khuyên về chăm sóc sức khỏe không dùng thuốc (ví dụ: nghỉ ngơi, uống đủ nước).",
        "   - 'disclaimer': Một tuyên bố từ chối trách nhiệm rõ ràng rằng đây chỉ là đơn thuốc tham khảo và cần tham khảo ý kiến chuyên gia y tế.",
        "   - 'price_disclaimer': Một tuyên bố từ chối trách nhiệm riêng cho giá thuốc, ví dụ: 'Lưu ý: Giá thuốc chỉ mang tính chất tham khảo tại thời điểm hiện tại và có thể thay đổi tùy thuộc vào nhà cung cấp và địa điểm.'",
        "",
        "Đảm bảo rằng toàn bộ output là một JSON hợp lệ và không có bất kỳ văn bản nào khác ngoài JSON. Nếu không thể kê đơn hoặc thông tin không đủ, hãy trả về một JSON trống cho 'drugs' và giải thích trong 'prescription_summary' và 'disclaimer'."
    ])

    final_prompt = "\n".join(prompt_parts)

    try:
        response = model.generate_content(final_prompt, generation_config={"response_mime_type": "application/json"})
        raw_json_str = response.text.strip().replace("```json", "").replace("```", "")
        analysis_data = json.loads(raw_json_str)

        # Ánh xạ dữ liệu JSON sang PrescriptionResponse schema
        prescription_drugs = [
            ai_schema.PrescriptionDrug(
                drug_name=item.get("drug_name", "N/A"),
                dosage=item.get("dosage", "N/A"),
                frequency=item.get("frequency", "N/A"),
                duration=item.get("duration", "N/A"),
                notes=item.get("notes"),
                estimated_price=item.get("estimated_price") # NEW: Ánh xạ estimated_price
            ) for item in analysis_data.get("drugs", []) if isinstance(item, dict)
        ]

        return ai_schema.PrescriptionResponse(
            prescription_summary=analysis_data.get("prescription_summary", "Không thể tạo đơn thuốc với thông tin đã cung cấp."),
            drugs=prescription_drugs,
            general_advice=analysis_data.get("general_advice"),
            disclaimer=analysis_data.get("disclaimer", "Lưu ý: Đơn thuốc này chỉ mang tính chất tham khảo. Vui lòng tham khảo ý kiến bác sĩ hoặc dược sĩ trước khi sử dụng bất kỳ loại thuốc nào."),
            price_disclaimer=analysis_data.get("price_disclaimer", "Lưu ý: Giá thuốc chỉ mang tính chất tham khảo tại thời điểm hiện tại và có thể thay đổi tùy thuộc vào nhà cung cấp và địa điểm.") # NEW: Ánh xạ price_disclaimer
        ).dict()
    except json.JSONDecodeError as e:
        print(f"LỖI PHÂN TÍCH JSON TỪ AI (Prescription): {e} - Phản hồi thô: {response.text}")
        raise HTTPException(status_code=500, detail="Lỗi phân tích kết quả từ AI. Định dạng phản hồi không hợp lệ.")
    except Exception as e:
        print(f"LỖI GỌI API GEMINI (Prescription): {e}")
        raise HTTPException(status_code=500, detail=f"Đã có lỗi xảy ra trong quá trình kê đơn: {e}")