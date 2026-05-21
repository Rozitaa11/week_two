import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:week_13/core/constants/app_constants.dart';
import 'package:week_13/features/auth/data/model/user_model.dart';

import '../../../../core/services/firebase_service.dart';

class AuthRemoteDataSource {
  final FirebaseAuth _auth = FirebaseService.auth;
  final FirebaseFirestore _firestore = FirebaseService.firestore;

  /// Signs in with email and password. Returns the UserModel on success.
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final doc = await _firestore
        .collection(AppConstants.usersCollection)
        .doc(credential.user!.uid)
        .get();
    return UserModel.fromFirestore(doc);
  }

  /// Creates a new account, saves profile to Firestore.
  Future<UserModel> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = UserModel(
      uid: credential.user!.uid,
      email: email,
      displayName: displayName,
      createdAt: DateTime.now(),
    );

    await _firestore
        .collection(AppConstants.usersCollection)
        .doc(user.uid)
        .set(user.toFirestore());

    // Also update Firebase Auth display name
    await credential.user!.updateDisplayName(displayName);

    return user;
  }

  /// Signs out the current user.
  Future<void> signOut() => _auth.signOut();

  /// Returns the current user's Firestore profile, or null.
  Future<UserModel?> getCurrentUser() async {
    final firebaseUser = _auth.currentUser;
    if (firebaseUser == null) return null;
    final doc = await _firestore
        .collection(AppConstants.usersCollection)
        .doc(firebaseUser.uid)
        .get();
    if (!doc.exists) return null;
    return UserModel.fromFirestore(doc);
  }

  /// Updates the user's photoUrl in Firestore.
  Future<void> updatePhotoUrl({
    required String uid,
    required String photoUrl,
  }) async {
    await _firestore.collection(AppConstants.usersCollection).doc(uid).update({
      'photoUrl': photoUrl,
    });
    await _auth.currentUser?.updatePhotoURL(photoUrl);
  }
}
