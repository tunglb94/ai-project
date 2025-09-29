// lib/domain/repositories/auth_repository.dart

import '../../domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<String> login(String email, String password);
  Future<UserEntity> register(String email, String password);
  Future<void> saveToken(String token); // Thêm dòng này
  Future<String?> getToken(); // Thêm dòng này
}