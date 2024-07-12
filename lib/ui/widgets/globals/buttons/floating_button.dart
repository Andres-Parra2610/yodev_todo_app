import 'package:flutter/material.dart';

class YDFloatingButton extends StatelessWidget {
  const YDFloatingButton({
    super.key,
    this.onPressed,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: const Icon(Icons.add),
    );
  }
}
