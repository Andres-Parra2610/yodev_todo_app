import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yodev_test/blocs/bloc/todo_bloc_bloc.dart';
import 'package:yodev_test/core/enums.dart';
import 'package:yodev_test/domain/models/todo.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({super.key, required this.todo});

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(todo.title),
      subtitle: Text(todo.dateString ?? 'Sin fecha'),
      secondary: PopupMenuButton<TodoPopUpEnum>(
        icon: const Icon(Icons.more_vert),
        onSelected: (TodoPopUpEnum result) {
          switch (result) {
            case TodoPopUpEnum.edit:
              // Código para editar
              break;
            case TodoPopUpEnum.delete:
              // Código para eliminar
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
