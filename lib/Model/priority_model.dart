enum TaskPriority { low, normal, urgent }

class Task {
  String title;
  String description;
  bool isCompleted;
  TaskPriority priority; // Add priority field

  Task({
    required this.title,
    required this.description,
    this.isCompleted = false,
    this.priority = TaskPriority.low, // Default priority
  });
}
