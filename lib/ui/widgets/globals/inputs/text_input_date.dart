import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yodev_test/ui/widgets/globals/inputs/text_field.dart';

class YDTextInputDate extends StatelessWidget {
  YDTextInputDate({
    super.key,
    this.validate,
    this.label,
    this.onChanged,
    this.initValue,
  }) {
    if (initValue != null) {
      _dateController.text = DateFormat('dd/MM/yyyy').format(initValue!);
    }
  }

  final Function? validate;
  final String? label;
  final void Function(DateTime?)? onChanged;
  final DateTime? initValue;

  @protected
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
