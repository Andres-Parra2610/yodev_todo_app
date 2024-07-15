import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yodev_test/blocs/bloc/todo_bloc_bloc.dart';
import 'package:yodev_test/core/enums.dart';
import 'package:yodev_test/domain/models/todo.dart';
import 'package:yodev_test/ui/screens/add_todo_screen.dart';
import 'package:yodev_test/ui/widgets/todo/todo_priority_burble.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({super.key, required this.todo});

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Row(
        children: [
          TodoPriorityBurble(priority: todo.priority),
          const SizedBox(width: 10),
          Flexible(
            child: Text(todo.title,
                overflow:
                    TextOverflow.ellipsis), // Agrega ellipsis al desbordamiento
          ),
        ],
      ),
      subtitle: Text(todo.dateString ?? 'Sin fecha'),
      secondary: PopupMenuButton<TodoPopUpEnum>(
        icon: const Icon(Icons.more_vert),
        onSelected: (TodoPopUpEnum result) {
          switch (result) {
            case TodoPopUpEnum.edit:
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddTodoScreen(todo: todo),
                ),
              );
              break;
            case TodoPopUpEnum.delete:
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Eliminar tarea'),
                  content: const Text('¿Estás seguro de eliminar esta tarea?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<TodoBloc>().add(DeleteTodo(todo));
                        Navigator.of(context).pop();
                      },
                      child: const Text('Eliminar'),
                    ),
                  ],
                ),
              );
              break;
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: TodoPopUpEnum.edit,
            child: Text('Editar'),
          ),
          const PopupMenuItem(
            value: TodoPopUpEnum.delete,
            child: Text('Eliminar'),
          ),
        ],
      ),
      checkColor: todo.isDone
          ? Theme.of(context).colorScheme.onSurface
          : Colors.transparent,
      side: WidgetStateBorderSide.resolveWith(
        (states) => const BorderSide(
          color: Colors.blue,
          strokeAlign: 10,
          width: .8,
        ),
      ),
      value: todo.isDone,
      fillColor: WidgetStateColor.resolveWith(
        (states) => Colors.transparent,
      ),
      controlAffinity: ListTileControlAffinity.leading,
      checkboxShape: const CircleBorder(),
      contentPadding: EdgeInsets.zero,
      onChanged: (bool? value) {
        if (value == null) return;
        context
            .read<TodoBloc>()
            .add(UpdateTodo(todo.copyWith(isDone: value), isToggle: true));
      },
    );
  }
}
