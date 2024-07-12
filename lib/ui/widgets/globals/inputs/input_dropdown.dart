import 'package:flutter/material.dart';

class YDInputDropdown<T> extends StatefulWidget {
  const YDInputDropdown(
      {super.key,
      required this.items,
      required this.onChanged,
      this.label,
      this.validator,
      this.value});

  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final String? label;
  final String? Function(T?)? validator;
  final T? value;

  @override
  State<YDInputDropdown<T>> createState() => _YDInputDropdownState<T>();
}

class _YDInputDropdownState<T> extends State<YDInputDropdown<T>> {
  T? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value;
  }

  @override
  void didUpdateWidget(YDInputDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    selectedValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: selectedValue,
      items: widget.items,
      onChanged: (value) {
        setState(() => selectedValue = value);
        widget.onChanged?.call(value);
      },
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.label,
        //hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      ),
    );
  }
}
