import 'package:equatable/equatable.dart';

enum UserRole { admin, user }

class User extends Equatable {
  final String username;
  final String email;
  final UserRole role;
  final String organization;

  const User({
    required this.username,
    required this.email,
    required this.role,
    required this.organization,
  });

  @override
  List<Object?> get props => [username, email, role, organization];
}
