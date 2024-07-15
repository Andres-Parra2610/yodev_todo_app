import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yodev_test/blocs/cubit/todo_filter_cubit.dart';
import 'package:yodev_test/core/enums.dart';

class TodoFilterDone extends StatelessWidget {
  const TodoFilterDone({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoFilterCubit, TodoFilterEnum>(
      builder: (context, state) {
        return SegmentedButton<TodoFilterEnum>(
          segments: const <ButtonSegment<TodoFilterEnum>>[
            ButtonSegment<TodoFilterEnum>(
              value: TodoFilterEnum.all,
              label: Text('Todas'),
            ),
            ButtonSegment<TodoFilterEnum>(
              value: TodoFilterEnum.done,
              label: Text('Hechas'),
            ),
            ButtonSegment<TodoFilterEnum>(
              value: TodoFilterEnum.undone,
              label: Text('No hechas'),
            ),
          ],
          selected: {state},
          onSelectionChanged: (newSelection) {
            context.read<TodoFilterCubit>().changeFilter(newSelection.first);
          },
        );
      },
    );
  }
}
