import 'package:week_13/features/auth/data/model/user_model.dart';

import '../../data/datasources/auth_remote_datasource.dart';

import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _dataSource;

  AuthRepositoryImpl(this._dataSource);

  @override
  Future<UserModel> login({required String email, required String password}) =>
      _dataSource.signInWithEmailAndPassword(email: email, password: password);

  @override
  Future<UserModel> register({
    required String email,
    required String password,
    required String displayName,
  }) => _dataSource.registerWithEmailAndPassword(
    email: email,
    password: password,
    displayName: displayName,
  );

  @override
  Future<void> signOut() => _dataSource.signOut();

  @override
  Future<UserModel?> getCurrentUser() => _dataSource.getCurrentUser();

  @override
  Future<void> updatePhotoUrl({
    required String uid,
    required String photoUrl,
  }) => _dataSource.updatePhotoUrl(uid: uid, photoUrl: photoUrl);
}
