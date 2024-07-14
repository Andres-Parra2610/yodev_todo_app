import 'package:flutter/material.dart';
import 'package:yodev_test/core/enums.dart';
import 'package:yodev_test/domain/models/todo.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({super.key, required this.todo});

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(todo.title),
      subtitle: Text('Prioridad: ${todo.priority.displayName}'),
      checkColor:
          true ? Theme.of(context).colorScheme.onSurface : Colors.transparent,
      side: WidgetStateBorderSide.resolveWith(
        (states) => const BorderSide(
          color: Colors.blue,
          strokeAlign: 10,
          width: .8,
        ),
      ),
      value: true,
      fillColor: WidgetStateColor.resolveWith(
        (states) => Colors.transparent,
      ),
      controlAffinity: ListTileControlAffinity.leading,
      checkboxShape: const CircleBorder(),
      contentPadding: EdgeInsets.zero,
      onChanged: (bool? value) {},
    );
  }
}
