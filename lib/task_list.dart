// import 'package:flutter/material.dart';
// import 'package:todo_list_app/Model/priority_model.dart';
// // import 'package:todo_list_app/Model/task_model.dart'; // Ensure this path is correct

// class TaskList extends StatelessWidget {
//   final List<Task> tasks;
//   final Function(Task) onDelete; // A callback for deleting tasks
//   final Function(Task) onEdit;   // A callback for editing tasks

//   const TaskList({
//     super.key,
//     required this.tasks,
//     required this.onDelete,
//     required this.onEdit,
//   });

//   // Function to get color based on priority
//   Color _getPriorityColor(TaskPriority priority) {
//     switch (priority) {
//       case TaskPriority.urgent:
//         return Colors.red; // Color for urgent tasks
//       case TaskPriority.normal:
//         return Colors.orange; // Color for normal tasks
//       case TaskPriority.low:
//         return Colors.green; // Color for low priority tasks
//       default:
//         return Colors.grey; // Default color if priority is unknown
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return tasks.isEmpty
//         ? const Center(child: Text('No tasks yet. Add a task to get started!'))
//         : ListView.builder(
//             itemCount: tasks.length,
//             itemBuilder: (context, index) {
//               final task = tasks[index];
//               return Column(
//                 children: [
//                   ListTile(
//                     title: Text(task.title),
//                     subtitle: Text(task.description),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         // Text with colored priority
//                         Text(
//                           task.priority.toString().split('.').last,
//                           style: TextStyle(
//                             color: _getPriorityColor(task.priority), // Assign color based on priority
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(width: 8),
//                         IconButton(
//                           onPressed: () {
//                             onEdit(task); // Pass the task to the onEdit callback
//                           },
//                           icon: const Icon(Icons.edit, color: Colors.blue),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.delete, color: Colors.grey),
//                           onPressed: () {
//                             // Show delete confirmation dialog before deleting task
//                             _showDeleteConfirmationDialog(context, task);
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                   // Add a divider only if it's not the last item
//                   if (index < tasks.length - 1) const Divider(),
//                 ],
//               );
//             },
//           );
//   }

//   // Show delete confirmation dialog
//   void _showDeleteConfirmationDialog(BuildContext context, Task task) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Delete Task'),
//           content: const Text('Are you sure you want to delete this task?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 onDelete(task); // Call onDelete to remove the task
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: const Text('Delete'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:todo_list_app/Model/priority_model.dart';
// import 'package:todo_list_app/Model/task_model.dart'; // Ensure this path is correct

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final Function(Task) onDelete; // A callback for deleting tasks
  final Function(Task) onEdit;   // A callback for editing tasks

  const TaskList({
    super.key,
    required this.tasks,
    required this.onDelete,
    required this.onEdit,
  });

  // Function to get color based on priority
  Color _getPriorityColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.urgent:
        return Colors.red; // Color for urgent tasks
      case TaskPriority.normal:
        return Colors.orange; // Color for normal tasks
      case TaskPriority.low:
        return Colors.green; // Color for low priority tasks
      default:
        return Colors.grey; // Default color if priority is unknown
    }
  }

  @override
  Widget build(BuildContext context) {
    // Sort tasks by priority: urgent -> normal -> low
    List<Task> sortedTasks = [...tasks]; // Create a copy of the tasks list
    sortedTasks.sort((a, b) => a.priority.index.compareTo(b.priority.index));

    return sortedTasks.isEmpty
        ? const Center(child: Text('No tasks yet. Add a task to get started!'))
        : ListView.builder(
            itemCount: sortedTasks.length,
            itemBuilder: (context, index) {
              final task = sortedTasks[index];
              return Column(
                children: [
                  ListTile(
                    title: Text(task.title, style: const TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: Text(task.description),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Text with colored priority
                        Text(
                          task.priority.toString().split('.').last,
                          style: TextStyle(
                            color: _getPriorityColor(task.priority), // Assign color based on priority
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () {
                            onEdit(task); // Pass the task to the onEdit callback
                          },
                          icon: const Icon(Icons.edit, color: Colors.blue),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.grey),
                          onPressed: () {
                            // Show delete confirmation dialog before deleting task
                            _showDeleteConfirmationDialog(context, task);
                          },
                        ),
                      ],
                    ),
                  ),
                  // Add a divider only if it's not the last item
                  if (index < sortedTasks.length - 1) const Divider(),
                ],
              );
            },
          );
  }

  // Show delete confirmation dialog
  void _showDeleteConfirmationDialog(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Task'),
          content: const Text('Are you sure you want to delete this task?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onDelete(task); // Call onDelete to remove the task
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
