class Todo {
  final String id;
  final String title;
  final int priority;
  final String? description;
  final DateTime? estimatedDate;
  final bool isDone;

  const Todo({
    required this.id,
    required this.title,
    required this.priority,
    this.description,
    this.estimatedDate,
    this.isDone = false,
  });

  Todo copyWith({
    String? name,
    int? priority,
    String? description,
    DateTime? estimatedDate,
    bool? isDone,
  }) {
    return Todo(
      id: id,
      title: name ?? this.title,
      priority: priority ?? this.priority,
      description: description ?? this.description,
      estimatedDate: estimatedDate ?? this.estimatedDate,
      isDone: isDone ?? this.isDone,
    );
  }
}
