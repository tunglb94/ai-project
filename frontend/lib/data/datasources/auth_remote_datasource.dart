// clone/frontend/lib/data/datasources/auth_remote_datasource.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../core/constants/app_constants.dart';

abstract class AuthRemoteDataSource {
  Future<String> login(String email, String password);
  Future<void> register(String email, String password, String fullName, String confirmPassword);
  Future<String> googleLogin(String idToken); // THÊM DÒNG NÀY
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final FlutterSecureStorage secureStorage;

  AuthRemoteDataSourceImpl({required this.client, required this.secureStorage});

  @override
  Future<String> login(String email, String password) async {
    final response = await client.post(
      Uri.parse('${AppConstants.baseUrl}/users/login'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: 'username=${Uri.encodeComponent(email)}&password=${Uri.encodeComponent(password)}',
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(utf8.decode(response.bodyBytes));
      return responseBody['access_token'];
    } else {
      final errorBody = json.decode(utf8.decode(response.bodyBytes));
      throw Exception('Đăng nhập thất bại: ${errorBody['detail']}');
    }
  }

  @override
  Future<void> register(String email, String password, String fullName, String confirmPassword) async {
    final response = await client.post(
      Uri.parse('${AppConstants.baseUrl}/users/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
        // Các trường này đã được comment out để khớp với backend hiện tại
        // 'full_name': fullName,
        // 'confirm_password': confirmPassword,
      }),
    );

    if (response.statusCode == 200) {
      return;
    } else {
      final errorBody = json.decode(utf8.decode(response.bodyBytes));
      throw Exception('Đăng ký thất bại: ${errorBody['detail']}');
    }
  }

  @override
  Future<String> googleLogin(String idToken) async {
    final response = await client.post(
      Uri.parse('${AppConstants.baseUrl}/users/google-login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'id_token': idToken}),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(utf8.decode(response.bodyBytes));
      return responseBody['access_token'];
    } else {
      final errorBody = json.decode(utf8.decode(response.bodyBytes));
      throw Exception('Đăng nhập Google thất bại: ${errorBody['detail']}');
    }
  }
}