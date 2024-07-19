import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:todo_list_app/task_list.dart';
// import '../providers/task_provider.dart';
import 'add_edit_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF000080),
        title: const Text('Task List', style: TextStyle(color: Color(0xFFFFFFFF))),
      ),
      body: const TaskList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF000080),
        foregroundColor: const Color(0xFFFFFFFF),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEditTaskScreen()),
          );
        },
        child: const Text('Add'),
      ),
    );
  }
}
