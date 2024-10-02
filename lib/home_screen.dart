import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/Model/priority_model.dart';
import 'package:todo_list_app/settings_screen.dart';
import 'package:todo_list_app/task_list.dart';
import 'package:todo_list_app/theme/theme.dart';
import 'package:todo_list_app/theme/theme_provider.dart';

import 'add_edit_task_screen.dart'; // Ensure this import is correct

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Task> tasks = [];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            isDarkMode ? Colors.black : Theme.of(context).colorScheme.primary,
        // centerTitle: true,
        title:
            const Text('Task List', style: TextStyle(color: Color(0xFFFFFFFF))),
        actions: [
          PopupMenuButton<int>(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).colorScheme.surface,
            ),
            onSelected: (value) {
              if (value == 0) {
                themeProvider.toggleTheme();
              } else if (value == 2) {
                _showAboutDialog(context);
              } else if (value == 3) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              } else if (value == 4) {
                _sortTasks();
              } else if (value == 5) {
                _clearCompletedTasks();
              } else if (value == 6) {
                _backupData();
              } else if (value == 7) {
                _restoreData();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Dark Mode'),
                    Transform.scale(
                      scale: 0.6,
                      child: Switch(
                        value: themeProvider.themeData == darkMode,
                        onChanged: (value) {
                          themeProvider.toggleTheme();
                          Navigator.pop(context);
                        },
                        activeColor: Theme.of(context)
                            .colorScheme
                            .surface, // Change the active thumb color
                        activeTrackColor: Theme.of(context)
                            .colorScheme
                            .primary, // Change the active track color
                        inactiveThumbColor: Theme.of(context)
                            .colorScheme
                            .primary, // Change the inactive thumb color
                        inactiveTrackColor: Theme.of(context)
                            .colorScheme
                            .surface, // Change the inactive track color
                      ),
                    ),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Icon(Icons.sort, size: 18),
                    SizedBox(width: 10),
                    Text('Sort Tasks'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 2,
                child: Row(
                  children: [
                    Icon(Icons.info_outline, size: 18),
                    SizedBox(width: 10),
                    Text('About'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 3,
                child: Row(
                  children: [
                    Icon(Icons.settings, size: 18),
                    SizedBox(width: 10),
                    Text('Settings'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 4,
                child: Row(
                  children: [
                    Icon(Icons.backup, size: 18),
                    SizedBox(width: 10),
                    Text('Backup Data'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 5,
                child: Row(
                  children: [
                    Icon(Icons.restore, size: 18),
                    SizedBox(width: 10),
                    Text('Restore Data'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 6,
                child: Row(
                  children: [
                    Icon(Icons.delete_sweep, size: 18),
                    SizedBox(width: 10),
                    Text('Clear Completed Tasks'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: TaskList(
        tasks: tasks, // Pass the tasks to TaskList
        onDelete: (task) {
          _deleteTask(task); // Use the delete function
        },
        onEdit: (task) async {
          // Open AddEditTaskScreen for editing
          final updatedTask = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddEditTaskScreen(task: task)),
          );
          if (updatedTask != null) {
            setState(() {
              // Update the task in the list
              final index = tasks.indexOf(task);
              if (index != -1) {
                tasks[index] = updatedTask; // Replace with updated task
              }
            });
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: const Color(0xFFFFFFFF),
        onPressed: () async {
          // Navigate to the AddEditTaskScreen and wait for the result
          final newTask = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEditTaskScreen()),
          );

          // Check if a task was returned and add it to the list
          if (newTask != null && newTask is Task) {
            setState(() {
              tasks.add(newTask);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // Method to delete a task from the list
  void _deleteTask(Task task) {
    setState(() {
      tasks.remove(task);
    });
  }

  // Show About dialog
  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Todo List App',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(Icons.monetization_on),
      children: [
        const Text(
          'This app allows users to manage their tasks efficiently, offering features like task prioritization, theme switching, and real-time task updates.',
        ),
      ],
    );
  }

  // Placeholder methods for new menu actions
  void _sortTasks() {
    // Add sorting functionality here
    print("Sort Tasks Clicked");
  }

  void _clearCompletedTasks() {
    // Add functionality to clear completed tasks here
    print("Clear Completed Tasks Clicked");
  }

  void _backupData() {
    // Add data backup functionality here
    print("Backup Data Clicked");
  }

  void _restoreData() {
    // Add data restore functionality here
    print("Restore Data Clicked");
  }
}
