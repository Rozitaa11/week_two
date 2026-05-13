import 'package:week_13/features/auth/data/model/user_model.dart';

import '../repositories/auth_repository.dart';

class RegisterUser {
  final AuthRepository _repository;

  RegisterUser(this._repository);

  Future<UserModel> call({
    required String email,
    required String password,
    required String displayName,
  }) => _repository.register(
    email: email,
    password: password,
    displayName: displayName,
  );
}
