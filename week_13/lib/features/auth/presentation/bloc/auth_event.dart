part of 'auth_bloc.dart';

abstract class AuthEvent {}

/// Fired on app startup to restore session.
class AppStarted extends AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested({required this.email, required this.password});
}

class RegisterRequested extends AuthEvent {
  final String email;
  final String password;
  final String displayName;

  RegisterRequested({
    required this.email,
    required this.password,
    required this.displayName,
  });
}

class LogoutRequested extends AuthEvent {}
