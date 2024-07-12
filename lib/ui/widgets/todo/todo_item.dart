import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({super.key});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: const Text('Esta es una tarea pendiente'),
      subtitle: const Text('Prioridad: baja'),
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
