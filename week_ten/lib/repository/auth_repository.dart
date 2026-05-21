import 'package:week_ten_dashboard_app/models/user.dart';

class AuthRepository {
  final Map<String, User> _users = {
    'admin': User(
      username: 'admin',
      email: 'admin@company.com',
      role: UserRole.admin,
      organization: 'Enterprise HQ',
    ),
    'user': User(
      username: 'user',
      email: 'user@company.com',
      role: UserRole.user,
      organization: 'Operations',
    ),
  };

  Future<User> signIn(
      {required String username,
      required String password,
      required UserRole selectedRole}) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));

    final user = _users[username.toLowerCase()];
    if (user == null) {
      throw Exception('Username not found.');
    }
    if (password != 'password123') {
      throw Exception('Invalid password. Use password123 for demo login.');
    }
    if (user.role != selectedRole) {
      throw Exception('Selected role does not match account role.');
    }
    return user;
  }

  Future<void> signOut() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
  }
}
