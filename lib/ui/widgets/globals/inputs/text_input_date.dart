import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yodev_test/ui/widgets/globals/inputs/text_field.dart';

class YDTextInputDate extends StatelessWidget {
  YDTextInputDate(
      {super.key,
      this.validate,
      this.initValue = '',
      this.label,
      this.onChanged});

  final Function? validate;
  final String? initValue;
  final String? label;
  final void Function(DateTime?)? onChanged;

  @protected
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _dateController.text = initValue ?? '';

    return YDTextField(
        label: label,
        controller: _dateController,
        readOnly: true,
        onTap: () async {
          final DateTime? date = await showDatePicker(
            context: context,
            firstDate: DateTime.now(),
            lastDate: DateTime(2100),
          );

          if (date == null) return;

          String dateFormat = DateFormat('dd/MM/yyyy').format(date);
          _dateController.text = dateFormat;
          onChanged?.call(date);
        },
        validator: validate == null ? null : (value) => validate!(value));
  }
}
