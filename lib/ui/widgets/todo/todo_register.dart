import 'package:flutter/material.dart';
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
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priorityController = TextEditingController();
  final _descriptionController = TextEditingController();

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;
    print('Form submitted');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          YDTextField(
            label: 'Nombre de la tarea',
            controller: _nameController,
            validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
          ),
          const SizedBox(height: 20),
          YDTextInputDate(
            label: 'Fecha estimada de finalización',
            onChanged: (value) {
              print(value);
            },
          ),
          const SizedBox(height: 20),
          YDInputDropdown<String>(
              label: 'Prioridad',
              items: const [
                DropdownMenuItem(
                  value: '1',
                  child: Text('Alta'),
                ),
                DropdownMenuItem(
                  value: '2',
                  child: Text('Media'),
                ),
                DropdownMenuItem(
                  value: '3',
                  child: Text('Baja'),
                ),
              ],
              onChanged: (p0) {
                print(p0);
              }),
          const SizedBox(height: 20),
          const YDTextField(
            label: 'Descripción de la tarea',
            maxLines: 5,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _onSubmit,
            child: const Text('Añadir'),
          ),
        ],
      ),
    );
  }
}
