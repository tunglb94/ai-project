// clone/frontend/lib/presentation/bloc/auth/auth_state.dart

import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading(); // Đảm bảo constructor là const nếu không có tham số thay đổi
}

class AuthAuthenticated extends AuthState {
  const AuthAuthenticated(); // Đảm bảo constructor là const
}

class AuthUnauthenticated extends AuthState {
  final String? error; // Thêm trường error
  const AuthUnauthenticated({this.error}); // Thêm constructor với error

  @override
  List<Object> get props => [error ?? '']; // Bao gồm error trong props
}

class AuthFailure extends AuthState { // Đây là một trạng thái lỗi chung, có thể dùng thay cho AuthUnauthenticated(error: ...)
  final String error;
  const AuthFailure(this.error);

  @override
  List<Object> get props => [error];
}