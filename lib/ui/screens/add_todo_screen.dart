import 'package:flutter/material.dart';
import 'package:yodev_test/domain/models/todo.dart';
import 'package:yodev_test/ui/widgets/todo/todo_form.dart';

class AddTodoScreen extends StatelessWidget {
  const AddTodoScreen({super.key, this.todo});

  final Todo? todo;

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
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: TodoForm(
          todo: todo,
        ),
      )),
    );
  }
}
