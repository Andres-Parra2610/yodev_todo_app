import 'package:flutter/material.dart';
import 'package:yodev_test/core/enums.dart';

class TodoPriorityBurble extends StatelessWidget {
  const TodoPriorityBurble({super.key, required this.priority});

  final TodoPriorityEnum priority;
  final double size = 8;

  @override
  Widget build(BuildContext context) {
    if (priority == TodoPriorityEnum.high) {
      return Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ));
    }
    if (priority == TodoPriorityEnum.medium) {
      return Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.circle,
          ));
    }
    if (priority == TodoPriorityEnum.low) {
      return Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ));
    }
    return const SizedBox.shrink();
  }
}
