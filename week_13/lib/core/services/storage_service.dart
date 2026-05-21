import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:week_13/core/constants/app_constants.dart';

import 'firebase_service.dart';

class StorageService {
  /// Uploads a profile image and returns the download URL.
  /// [userId] is used to namespace the file so each user has their own image.
  Future<String> uploadProfileImage({
    required String userId,
    required File imageFile,
    void Function(double progress)? onProgress,
  }) async {
    final ref = FirebaseService.storage
        .ref()
        .child(AppConstants.profileImagesPath)
        .child('$userId.jpg');

    final uploadTask = ref.putFile(
      imageFile,
      SettableMetadata(contentType: 'image/jpeg'),
    );

    // Listen to progress if callback provided
    if (onProgress != null) {
      uploadTask.snapshotEvents.listen((snapshot) {
        final progress = snapshot.bytesTransferred / snapshot.totalBytes;
        onProgress(progress);
      });
    }

    await uploadTask;
    return await ref.getDownloadURL();
  }

  /// Deletes the profile image for [userId].
  Future<void> deleteProfileImage(String userId) async {
    try {
      final ref = FirebaseService.storage
          .ref()
          .child(AppConstants.profileImagesPath)
          .child('$userId.jpg');
      await ref.delete();
    } on FirebaseException catch (e) {
      // object-not-found is fine — nothing to delete
      if (e.code != 'object-not-found') rethrow;
    }
  }
}
