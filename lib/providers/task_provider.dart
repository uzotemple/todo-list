// import 'package:flutter/material.dart';

// class TaskProvider with ChangeNotifier {
//   final List<String> _tasks = [];

//   List<String> get tasks => _tasks;

//   void addTask(String task) {
//     _tasks.add(task);
//     notifyListeners();
//   }

//   void deleteTask(int index) {
//     if (index >= 0 && index < _tasks.length) {
//       _tasks.removeAt(index);
//       notifyListeners();
//     }
//   }

//   void updateTask(int index, String newTask) {
//     if (index >= 0 && index < _tasks.length) {
//       _tasks[index] = newTask;
//       notifyListeners();
//     }
//   }

//   int getTaskIndex(String task) {
//     return _tasks.indexOf(task);
//   }
// }


import 'package:flutter/material.dart';
import 'package:todo_list_app/Model/priority_model.dart';
// import 'package:todo_list_app/Model/task.dart'; // Import your Task model

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }

  // Add any other methods for handling tasks
}
