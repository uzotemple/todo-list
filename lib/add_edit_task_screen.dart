import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';

class AddEditTaskScreen extends StatefulWidget {
  final String? task;

  const AddEditTaskScreen({super.key, this.task});

  @override
  AddEditTaskScreenState createState() => AddEditTaskScreenState();
}

class AddEditTaskScreenState extends State<AddEditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _taskController.text = widget.task!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF000080),
        title: Text(widget.task == null ? 'Add Task' : 'Edit Task',
        style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, // Change the color of the back arrow icon to white
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _taskController,
                decoration: const InputDecoration(labelText: 'Task'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a task';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (widget.task == null) {
                      Provider.of<TaskProvider>(context, listen: false).addTask(_taskController.text);
                    } else {
                      int index = Provider.of<TaskProvider>(context, listen: false).getTaskIndex(widget.task!);
                      if (index != -1) {
                        Provider.of<TaskProvider>(context, listen: false).updateTask(index, _taskController.text);
                      }
                    }
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF000080),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }
}
