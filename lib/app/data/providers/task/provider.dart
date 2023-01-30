import 'dart:convert';
import 'package:get/get.dart';
import 'package:getx_task/app/core/utils/keys.dart';
import '../../models/task.dart';
import '../../services/storage/services.dart';

class TaskProvider {
  // storage: noi cung cap data
  final StorageService _storage = Get.find<StorageService>();

  /*
  format task in database
  {
    'tasks': [
      {
        'title' : 'work',
        'color' : '#ff123456'
        'icon' : 0xe123,
      }
    ]
  }
  */
  /// lay data tu json luu in local
  List<Task> readTasks() {
    var tasks = <Task>[];
    for (var e in jsonDecode(_storage.read(taskKey).toString())) {
      tasks.add(Task.fromJson(e));
    }
    return tasks;
  }

  /// luu data vao storage
  void writeTasks(List<Task> tasks) {
    _storage.write(taskKey, jsonEncode(tasks));
  }
}
