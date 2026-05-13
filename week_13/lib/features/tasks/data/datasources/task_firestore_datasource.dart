import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:week_13/core/constants/app_constants.dart';

import '../../../../core/services/firebase_service.dart';
import '../models/task_model.dart';

class TaskFirestoreDataSource {
  CollectionReference<Map<String, dynamic>> get _collection =>
      FirebaseService.firestore.collection(AppConstants.tasksCollection);

  /// Adds a new task. Firestore auto-generates the document ID.
  Future<TaskModel> addTask(TaskModel task) async {
    final docRef = await _collection.add(task.toFirestore());
    final snap = await docRef.get();
    return TaskModel.fromFirestore(snap);
  }

  /// Updates only the provided fields (partial update).
  Future<void> updateTask(TaskModel task) async {
    await _collection.doc(task.id).update(task.toFirestore());
  }

  /// Deletes the task document.
  Future<void> deleteTask(String taskId) async {
    await _collection.doc(taskId).delete();
  }

  /// Streams all tasks belonging to [userId], ordered by creation date.
  Stream<List<TaskModel>> getTasks(String userId) {
    return _collection
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map(TaskModel.fromFirestore).toList());
  }
}
