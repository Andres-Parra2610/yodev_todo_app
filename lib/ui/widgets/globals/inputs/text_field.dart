import 'package:flutter/material.dart';

class YDTextField extends StatelessWidget {
  const YDTextField({
    super.key,
    this.borderRadius,
    this.label = '',
    this.suffixIcon,
    this.maxLines,
    this.readOnly = false,
    this.controller,
    this.onTap,
    this.validator,
  });

  final BorderRadius? borderRadius;
  final String? label;
  final Widget? suffixIcon;
  final int? maxLines;
  final bool? readOnly;
  final TextEditingController? controller;
  final void Function()? onTap;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly!,
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(10),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        labelText: label,
        alignLabelWithHint: true,
        suffixIcon: suffixIcon,
      ),
      onTap: onTap,
      validator: validator,
    );
  }
}
