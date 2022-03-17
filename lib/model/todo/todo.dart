class Todo {
  final int todoId;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  Todo({
    required this.todoId,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': todoId,
      'title': title,
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
