import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

/// Central access point for Firebase instances.
/// Use this throughout the app instead of calling .instance directly.
class FirebaseService {
  FirebaseService._();

  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final FirebaseStorage storage = FirebaseStorage.instance;

  /// Returns the currently signed-in user, or null.
  static User? get currentUser => auth.currentUser;

  /// Stream that emits whenever auth state changes.
  static Stream<User?> get authStateChanges => auth.authStateChanges();
}
