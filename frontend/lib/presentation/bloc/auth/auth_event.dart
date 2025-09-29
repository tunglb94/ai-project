// clone/frontend/lib/presentation/bloc/auth/auth_event.dart

import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {
  const AppStarted();

  @override
  List<Object> get props => [];
}

class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class AuthRegisterRequested extends AuthEvent {
  final String email;
  final String password;
  final String fullName;
  final String confirmPassword;

  const AuthRegisterRequested({
    required this.email,
    required this.password,
    required this.fullName,
    required this.confirmPassword,
  });

  @override
  List<Object> get props => [email, password, fullName, confirmPassword];
}

class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();

  @override
  List<Object> get props => [];
}

class LoggedIn extends AuthEvent {
  final String token;
  const LoggedIn(this.token);

  @override
  List<Object> get props => [token];
}

class AuthGoogleLoginRequested extends AuthEvent {
  final String idToken;

  const AuthGoogleLoginRequested({required this.idToken});

  @override
  List<Object> get props => [idToken];
}