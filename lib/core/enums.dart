enum TodoPriorityEnum { low, medium, high }

enum TodoPopUpEnum { edit, delete }

enum TodoFilterEnum { all, done, undone }

extension TodoPriorityExtension on TodoPriorityEnum {
  String get displayName {
    switch (this) {
      case TodoPriorityEnum.low:
        return 'Baja';
      case TodoPriorityEnum.medium:
        return 'Media';
      case TodoPriorityEnum.high:
        return 'Alta';
    }
  }

  static TodoPriorityEnum fromString(String priority) {
    switch (priority.toLowerCase()) {
      case 'baja':
        return TodoPriorityEnum.low;
      case 'media':
        return TodoPriorityEnum.medium;
      case 'alta':
        return TodoPriorityEnum.high;
      default:
        throw FormatException('Unknown priority level: $priority');
    }
  }
}
