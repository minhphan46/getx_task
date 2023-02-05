import 'package:getx_task/app/data/providers/task/provider.dart';
import '../../models/task.dart';

class TaskRepository {
  TaskProvider taskProvider;
  TaskRepository({required this.taskProvider});

  /// read the tasks
  List<Task> readTask() => taskProvider.readTasks();

  /// write the tasks
  void writeTasks(List<Task> tasks) => taskProvider.writeTasks(tasks);
}
