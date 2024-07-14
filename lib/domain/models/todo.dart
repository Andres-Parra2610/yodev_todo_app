import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  final String? id;
  final String title;
  final String priority;
  final String? description;
  final DateTime? estimatedDate;
  final bool isDone;

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
      priority: json['priority'] as String,
      description: json['description'] as String?,
      estimatedDate: json['estimatedDate'] != null
          ? (json['estimatedDate'] as Timestamp).toDate()
          : null,
      isDone: json['isDone'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'priority': priority,
      'description': description,
      'estimatedDate': estimatedDate?.toIso8601String(),
      'isDone': isDone,
    };
  }

  Todo copyWith({
    String? id,
    String? title,
    String? priority,
    String? description,
    DateTime? estimatedDate,
    bool? isDone,
  }) {
    return Todo(
      id: id,
      title: title ?? this.title,
      priority: priority ?? this.priority,
      description: description ?? this.description,
      estimatedDate: estimatedDate ?? this.estimatedDate,
      isDone: isDone ?? this.isDone,
    );
  }
}
