enum TodoPriority { low, medium, high }

extension TodoPriorityExtension on TodoPriority {
  String get displayName {
    switch (this) {
      case TodoPriority.low:
        return 'Baja';
      case TodoPriority.medium:
        return 'Media';
      case TodoPriority.high:
        return 'Alta';
    }
  }

  static TodoPriority fromString(String priority) {
    switch (priority.toLowerCase()) {
      case 'baja':
        return TodoPriority.low;
      case 'media':
        return TodoPriority.medium;
      case 'alta':
        return TodoPriority.high;
      default:
        throw FormatException('Unknown priority level: $priority');
    }
  }
}
