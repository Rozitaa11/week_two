import 'package:week_13/features/auth/data/model/user_model.dart';

abstract class AuthRepository {
  Future<UserModel> login({required String email, required String password});

  Future<UserModel> register({
    required String email,
    required String password,
    required String displayName,
  });

  Future<void> signOut();

  Future<UserModel?> getCurrentUser();

  Future<void> updatePhotoUrl({required String uid, required String photoUrl});
}
