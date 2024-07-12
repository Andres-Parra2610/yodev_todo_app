import 'package:flutter/material.dart';
import 'package:yodev_test/ui/widgets/todo/todo_register.dart';

class AddTodoScreen extends StatelessWidget {
  const AddTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir tarea'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        elevation: 0,
        centerTitle: false,
      ),
      body: const SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(15),
        child: TodoRegisterForm(),
      )),
    );
  }
}
