import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/add_edit_task_screen.dart';
import '../providers/task_provider.dart';
// import '../screens/add_edit_task_screen.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        return ListView.builder(
          itemCount: taskProvider.tasks.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(taskProvider.tasks[index]),
              trailing: CircleAvatar(
                backgroundColor: const Color(0xFF000080),
                child: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.white,),
                  onPressed: () {
                    taskProvider.deleteTask(index);
                  },
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddEditTaskScreen(task: taskProvider.tasks[index]),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
