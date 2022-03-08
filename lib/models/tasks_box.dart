import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:todoey_flutter/models/task.dart';

class TasksBox extends ChangeNotifier {
  Box tasksBox = Hive.box('tasks');

  void addTask(Task task) {
    final tasksBox = Hive.box('tasks');
    tasksBox.add(task);
    notifyListeners();
  }

  void updateTask(int index, Task task, {bool check = false}) {
    final tasksBox = Hive.box('tasks');
    check ? task.isCheck() : null;
    tasksBox.putAt(index, task);
    notifyListeners();
  }

  void deleteTask(int index) {
    final tasksBox = Hive.box('tasks');
    tasksBox.deleteAt(index);
    notifyListeners();
  }
}
