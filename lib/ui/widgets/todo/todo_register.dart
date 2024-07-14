import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yodev_test/blocs/bloc/todo_bloc_bloc.dart';
import 'package:yodev_test/core/enums.dart';
import 'package:yodev_test/domain/models/todo.dart';
import 'package:yodev_test/ui/widgets/globals/inputs/input_dropdown.dart';
import 'package:yodev_test/ui/widgets/globals/inputs/text_field.dart';
import 'package:yodev_test/ui/widgets/globals/inputs/text_input_date.dart';

class TodoRegisterForm extends StatefulWidget {
  const TodoRegisterForm({
    super.key,
  });

  @override
  State<TodoRegisterForm> createState() => _TodoRegisterFormState();
}

class _TodoRegisterFormState extends State<TodoRegisterForm> {
  // Cpntrollers
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  // Values
  TodoPriorityEnum? _priority;
  DateTime? _dateTime;

  // On submit method
  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;
    final todo = Todo(
      title: _titleController.text,
      priority: _priority!,
      estimatedDate: _dateTime,
      description: _descriptionController.text,
    );
    context.read<TodoBloc>().add(AddTodo(todo));
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
            required: true,
            items: TodoPriorityEnum.values
                .map(
                  (el) => DropdownMenuItem(
                    value: el,
                    child: Text(el.displayName),
                  ),
                )
                .toList(),
            onChanged: (value) => _priority = value,
            validator: (value) => value == null ? 'Campo requerido' : null,
          ),
          const SizedBox(height: 20),
          YDTextInputDate(
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
              if (state is TodoAddLoading) {
                return const CircularProgressIndicator();
              }
              return ElevatedButton(
                onPressed: _onSubmit,
                child: const Text('Añadir'),
              );
            },
          ),
        ],
      ),
    );
  }
}
