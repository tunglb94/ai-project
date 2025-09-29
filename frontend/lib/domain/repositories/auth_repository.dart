// frontend/lib/domain/repositories/auth_repository.dart

// import '../../domain/entities/user_entity.dart'; // ĐÃ XÓA: Unused import

abstract class AuthRepository {
  Future<String> login(String email, String password);
  Future<void> register(String email, String password, String fullName, String confirmPassword);
  Future<void> logout();
  Future<String?> getToken();
  Future<void> persistToken(String token);
  Future<void> deleteToken();
  Future<String> googleLogin(String idToken); // KHAI BÁO NÀY PHẢI CÓ
}