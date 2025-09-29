// clone/frontend/lib/data/repositories/auth_repository_impl.dart

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final FlutterSecureStorage secureStorage;

  AuthRepositoryImpl({required this.remoteDataSource, required this.secureStorage});

  @override
  Future<String> login(String email, String password) async {
    final token = await remoteDataSource.login(email, password);
    await persistToken(token);
    return token;
  }

  @override
  Future<void> register(String email, String password, String fullName, String confirmPassword) async {
    await remoteDataSource.register(email, password, fullName, confirmPassword);
  }

  @override
  Future<void> logout() async {
    await deleteToken();
  }

  @override
  Future<String?> getToken() async {
    return await secureStorage.read(key: 'token');
  }

  @override
  Future<void> persistToken(String token) async {
    await secureStorage.write(key: 'token', value: token);
  }

  @override
  Future<void> deleteToken() async {
    await secureStorage.delete(key: 'token');
  }

  @override
  Future<String> googleLogin(String idToken) async {
    final token = await remoteDataSource.googleLogin(idToken);
    await persistToken(token);
    return token;
  }
}