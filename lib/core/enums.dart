/// This file contains all the enums used in the app

/// This enum represents the priority of the todo
enum TodoPriorityEnum { low, medium, high }

/// This enum represents the pop up menu of the todo
enum TodoPopUpEnum { edit, delete }

/// This enum represents the filter of the todos
enum TodoFilterEnum { all, done, undone }

/// This extension is used to get the display name of the priority and convert it to a string
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
