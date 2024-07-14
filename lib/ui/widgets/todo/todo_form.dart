import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yodev_test/blocs/bloc/todo_bloc_bloc.dart';
import 'package:yodev_test/core/enums.dart';
import 'package:yodev_test/domain/models/todo.dart';
import 'package:yodev_test/ui/widgets/globals/inputs/input_dropdown.dart';
import 'package:yodev_test/ui/widgets/globals/inputs/text_field.dart';
import 'package:yodev_test/ui/widgets/globals/inputs/text_input_date.dart';
import 'package:yodev_test/ui/widgets/todo/todo_priority_burble.dart';

class TodoForm extends StatefulWidget {
  const TodoForm({
    super.key,
    this.todo,
  });

  final Todo? todo;

  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  // Cpntrollers
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  // Values
  TodoPriorityEnum? _priority;
  DateTime? _dateTime;

  @override
  void initState() {
    super.initState();

    // Update values is todo is not null
    if (widget.todo == null) return;
    _priority = widget.todo?.priority;
    _dateTime = widget.todo?.estimatedDate;
    _titleController.text = widget.todo?.title ?? '';
    _descriptionController.text = widget.todo?.description ?? '';
  }

  // On submit method
  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    // If todo is null, create a new one else update the existing one
    if (widget.todo == null) {
      final todo = Todo(
        title: _titleController.text,
        priority: _priority!,
        estimatedDate: _dateTime,
        description: _descriptionController.text,
      );
      context.read<TodoBloc>().add(AddTodo(todo));
    } else {
      final todo = widget.todo!.copyWith(
        title: _titleController.text,
        priority: _priority!,
        estimatedDate: _dateTime,
        description: _descriptionController.text,
      );
      context.read<TodoBloc>().add(UpdateTodo(todo));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          YDTextField(
            required: true,
            label: 'Nombre de la tarea',
            controller: _titleController,
            validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
          ),
          const SizedBox(height: 20),
          YDInputDropdown<TodoPriorityEnum>(
            label: 'Prioridad',
            value: _priority,
            required: true,
            items: TodoPriorityEnum.values
                .map(
                  (el) => DropdownMenuItem(
                      value: el,
                      child: Row(
                        children: [
                          TodoPriorityBurble(priority: el),
                          const SizedBox(width: 10),
                          Text(el.displayName),
                        ],
                      )),
                )
                .toList(),
            onChanged: (value) => _priority = value,
            validator: (value) => value == null ? 'Campo requerido' : null,
          ),
          const SizedBox(height: 20),
          YDTextInputDate(
            initValue: _dateTime,
            label: 'Fecha estimada de finalización',
            onChanged: (value) => _dateTime = value,
          ),
          const SizedBox(height: 20),
          YDTextField(
            label: 'Descripción de la tarea',
            maxLines: 5,
            controller: _descriptionController,
          ),
          const SizedBox(height: 20),
          BlocConsumer<TodoBloc, TodoState>(
            listener: (context, state) {
              if (state is TodoSucces) {
                Navigator.of(context).pop();
              }
            },
            builder: (context, state) {
              if (state is TodoSubmitLoading) {
                return const CircularProgressIndicator();
              }
              return ElevatedButton(
                onPressed: _onSubmit,
                child: widget.todo == null
                    ? const Text('Añadir')
                    : const Text('Editar'),
              );
            },
          ),
        ],
      ),
    );
  }
}
