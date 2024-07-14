import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yodev_test/blocs/bloc/todo_bloc_bloc.dart';
import 'package:yodev_test/ui/widgets/todo/todo_item.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state is TodoInitial) {
          return const SizedBox();
        }

        if (state is TodosLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is TodosError) {
          return Center(child: Text(state.message));
        }

        final todos = (state as TodosLoaded).todos;

        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final todo = todos[index];
            return TodoItem(todo: todo);
          },
        );
      },
    );
  }
}
