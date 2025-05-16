import 'package:flutter/foundation.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => [..._tasks];
  List<Task> get completedTasks => _tasks.where((task) => task.isCompleted).toList();
  List<Task> get pendingTasks => _tasks.where((task) => !task.isCompleted).toList();

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void toggleTaskStatus(String taskId) {
    final taskIndex = _tasks.indexWhere((task) => task.id == taskId);
    if (taskIndex >= 0) {
      _tasks[taskIndex].isCompleted = !_tasks[taskIndex].isCompleted;
      notifyListeners();
    }
  }

  void updateTask(Task updatedTask) {
    final taskIndex = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (taskIndex >= 0) {
      _tasks[taskIndex] = updatedTask;
      notifyListeners();
    }
  }

  void deleteTask(String taskId) {
    _tasks.removeWhere((task) => task.id == taskId);
    notifyListeners();
  }
}