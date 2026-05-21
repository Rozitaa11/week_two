import 'package:equatable/equatable.dart';
import 'package:week_ten_dashboard_app/models/user.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthRequested extends AuthEvent {
  final String username;
  final String password;
  final UserRole role;

  const AuthRequested({
    required this.username,
    required this.password,
    required this.role,
  });

  @override
  List<Object?> get props => [username, password, role];
}

class AuthLogoutRequested extends AuthEvent {}
