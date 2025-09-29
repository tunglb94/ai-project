// clone/frontend/lib/presentation/bloc/auth/auth_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(const AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
    on<AuthRegisterRequested>(_onAuthRegisterRequested);
    on<AuthGoogleLoginRequested>(_onAuthGoogleLoginRequested);
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    try {
      final token = await authRepository.getToken();
      if (token != null) {
        emit(const AuthAuthenticated());
      } else {
        emit(const AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthUnauthenticated(error: 'Lỗi khởi động ứng dụng: ${e.toString()}'));
    }
  }

  Future<void> _onAuthLoginRequested(AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      final token = await authRepository.login(event.email, event.password);
      if (token.isNotEmpty) {
        emit(const AuthAuthenticated());
      } else {
        emit(const AuthUnauthenticated(error: 'Đăng nhập thất bại.'));
      }
    } catch (e) {
      emit(AuthUnauthenticated(error: 'Lỗi đăng nhập: ${e.toString()}'));
    }
  }

  Future<void> _onAuthLogoutRequested(AuthLogoutRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      await authRepository.logout();
      emit(const AuthUnauthenticated());
    } catch (e) {
      emit(AuthUnauthenticated(error: 'Lỗi đăng xuất: ${e.toString()}'));
    }
  }

  Future<void> _onAuthRegisterRequested(AuthRegisterRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      await authRepository.register(event.email, event.password, event.fullName, event.confirmPassword);
      emit(const AuthAuthenticated());
    } catch (e) {
      emit(AuthUnauthenticated(error: 'Lỗi đăng ký: ${e.toString()}'));
    }
  }

  Future<void> _onAuthGoogleLoginRequested(AuthGoogleLoginRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading()); // Đã là AuthEvent
    try {
      final token = await authRepository.googleLogin(event.idToken);
      if (token.isNotEmpty) {
        emit(const AuthAuthenticated());
      } else {
        emit(const AuthUnauthenticated(error: 'Đăng nhập Google thất bại.'));
      }
    } catch (e) {
      emit(AuthUnauthenticated(error: 'Lỗi đăng nhập Google: ${e.toString()}'));
    }
  }
}