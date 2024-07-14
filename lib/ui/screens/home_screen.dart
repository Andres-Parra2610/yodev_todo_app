import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yodev_test/blocs/bloc/todo_bloc_bloc.dart';
import 'package:yodev_test/domain/models/todo.dart';
import 'package:yodev_test/ui/screens/add_todo_screen.dart';
import 'package:yodev_test/ui/widgets/globals/buttons/floating_button.dart';
import 'package:yodev_test/ui/widgets/globals/inputs/text_field.dart';
import 'package:yodev_test/ui/widgets/todo/todo_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de tareas'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              YDTextField(
                borderRadius: BorderRadius.circular(50),
                label: 'Buscar tarea...',
                suffixIcon: const Icon(Icons.search),
              ),
              const SizedBox(height: 10),
              const TodoList(),
            ],
          ),
        ),
      ),
      floatingActionButton: YDFloatingButton(
        /* onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AddTodoScreen()),
        ), */
        onPressed: () => context.read<TodoBloc>().add(
            const AddTodo(Todo(id: '34', title: 'Nuevo titulo', priority: 1))),
      ),
    );
  }
}
