import 'package:flutter/material.dart';
import 'controllers/todo_controller.dart';
import 'views/todo_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoScreen(
        controller: TodoController(),
      ),
    );
  }
}
