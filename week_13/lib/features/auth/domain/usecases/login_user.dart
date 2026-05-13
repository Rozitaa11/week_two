import 'package:week_13/features/auth/data/model/user_model.dart';

import '../repositories/auth_repository.dart';

class LoginUser {
  final AuthRepository _repository;

  LoginUser(this._repository);

  Future<UserModel> call({required String email, required String password}) =>
      _repository.login(email: email, password: password);
}
