import 'package:flutter/material.dart';
import 'package:yodev_test/ui/widgets/todo/todo_item.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 15,
      itemBuilder: (context, index) {
        return const TodoItem();
      },
    );
  }
}
