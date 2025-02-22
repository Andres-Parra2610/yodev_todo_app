import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:yodev_test/core/enums.dart';

/// This class represents a todo
class Todo {
  /// [String] The id of the todo (optional) used for updating and deleting
  final String? id;

  /// [String] The title of the todo (required)
  final String title;

  /// [TodoPriorityEnum] The priority of the todo (required), can be low, medium or high
  final TodoPriorityEnum priority;

  /// [String] The description of the todo (optional)
  final String? description;

  /// [DateTime] The estimated date of the todo (optional)
  final DateTime? estimatedDate;

  /// [bool] If the todo is done or not (required)
  final bool isDone;

  String? get dateString => estimatedDate != null
      ? DateFormat('d \'de\' MMMM \'de\' y', 'es_ES').format(estimatedDate!)
      : null;

  const Todo({
    required this.title,
    required this.priority,
    this.id,
    this.description,
    this.estimatedDate,
    this.isDone = false,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      title: json['title'] as String,
      priority: TodoPriorityExtension.fromString(json['priority'] as String),
      description: json['description'] as String?,
      estimatedDate: json['estimatedDate'] != null
          ? (json['estimatedDate'] as Timestamp).toDate()
          : null,
      isDone: json['isDone'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'priority': priority.displayName,
      'description': description,
      'estimatedDate':
          estimatedDate != null ? Timestamp.fromDate(estimatedDate!) : null,
      'isDone': isDone,
    };
  }

  Todo copyWith({
    String? id,
    String? title,
    TodoPriorityEnum? priority,
    String? description,
    DateTime? estimatedDate,
    bool? isDone,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      priority: priority ?? this.priority,
      description: description ?? this.description,
      estimatedDate: estimatedDate ?? this.estimatedDate,
      isDone: isDone ?? this.isDone,
    );
  }

  @override
  String toString() {
    return 'Todo{id: $id, title: $title, priority: $priority, description: $description, estimatedDate: $estimatedDate, isDone: $isDone}';
  }
}
