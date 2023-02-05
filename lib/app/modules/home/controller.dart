import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getx_task/app/data/services/storage/repository.dart';
import '../../data/models/task.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;
  HomeController({required this.taskRepository});
  final formKey = GlobalKey<FormState>();
  final editController = TextEditingController();
  final chipIndex = 0.obs;
  final tasks = <Task>[].obs;

  @override
  void onInit() {
    // get all task in local and assign to tasks
    tasks.assignAll(taskRepository.readTask());
    // when tasks change => write to local
    ever(tasks, (_) => taskRepository.writeTasks(tasks));
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeChipIndex(int value) {
    chipIndex.value = value;
  }

  bool addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    } else {
      tasks.add(task);
      return true;
    }
  }
}
