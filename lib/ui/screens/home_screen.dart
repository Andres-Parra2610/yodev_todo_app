import 'package:flutter/material.dart';
import 'package:yodev_test/ui/screens/add_todo_screen.dart';
import 'package:yodev_test/ui/widgets/globals/buttons/floating_button.dart';
import 'package:yodev_test/ui/widgets/todo/todo_filter_done.dart';
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
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              TodoFilterDone(),
              SizedBox(height: 20),
              TodoList(),
            ],
          ),
        ),
      ),
      floatingActionButton: YDFloatingButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AddTodoScreen()),
        ),
      ),
    );
  }
}
