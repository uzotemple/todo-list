import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/providers/task_provider.dart'; // Task Provider
import 'package:todo_list_app/theme/theme_provider.dart';  // Theme Provider
import 'home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Todo List',
          debugShowCheckedModeBanner: false,
          theme: themeProvider.themeData, // Use theme from ThemeProvider
          home: const HomeScreen(),
        );
      },
    );
  }
}
