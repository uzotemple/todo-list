import 'package:flutter/material.dart';

class TaskProvider with ChangeNotifier {
  final List<String> _tasks = [];

  List<String> get tasks => _tasks;

  void addTask(String task) {
    _tasks.add(task);
    notifyListeners();
  }

  void deleteTask(int index) {
    if (index >= 0 && index < _tasks.length) {
      _tasks.removeAt(index);
      notifyListeners();
    }
  }

  void updateTask(int index, String newTask) {
    if (index >= 0 && index < _tasks.length) {
      _tasks[index] = newTask;
      notifyListeners();
    }
  }

  int getTaskIndex(String task) {
    return _tasks.indexOf(task);
  }
}
