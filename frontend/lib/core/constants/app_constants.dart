// lib/core/constants/app_constants.dart

class AppConstants {
  // QUAN TRỌNG:
  // Nếu bạn chạy app trên máy ảo Android, dùng URL này
static const String baseUrl = 'http://10.0.2.2:8000/api/v1';
  // Nếu bạn chạy app trên máy ảo iOS, dùng URL này
  // static const String baseUrl = 'http://localhost:8000/api/v1';

  // Khi chạy trên điện thoại thật, hãy thay bằng địa chỉ IP của máy tính trong cùng mạng WiFi
  // Ví dụ: static const String baseUrl = 'http://192.168.1.10:8000/api/v1';
}