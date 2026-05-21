import 'package:flutter/foundation.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:week_six/models/task.dart';

//ALl the crud operations will be performed in this class

class HiveDataStore {
  static const boxName = 'taskBox';
  final Box<Task> box = Hive.box<Task>(boxName);
  // ADD TASK TO BOX
  Future<void> addTask({required Task task}) async {
    await box.put(task.id, task);
  }

  // show task
  Future<Task?> getTask({required String id}) async {
    return box.get(id);
  }

  //update  task
  Future<void> updateTask({required Task task}) async {
    await task.save();
  }

  // delete task
  Future<void> deleteTask({required Task task}) async {
    await task.delete();
  }

  //listen box changes
  // using this method we will listen to the changes in the box and update the UI accordingly
  ValueListenable<Box<Task>> listenToTaskBox() {
    return box.listenable();
  }
}
