import 'dart:convert';

class TodoItem {
  final int? id;
  final String title;
  final String description;
  final bool isDone;

  TodoItem(
    this.id,
    this.title,
    this.description,
    this.isDone,
  );

  TodoItem copyWith({
    int? id,
    String? title,
    String? description,
    bool? isDone,
  }) {
    return TodoItem(
      id ?? this.id,
      title ?? this.title,
      description ?? this.description,
      isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isDone': isDone,
    };
  }

  factory TodoItem.fromMap(Map<String, dynamic> map) {
    return TodoItem(
      map['id']?.toInt(),
      map['title'] ?? '',
      map['description'] ?? '',
      map['isDone'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoItem.fromJson(String source) =>
      TodoItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TodoItem(id: $id, title: $title, description: $description, isDone: $isDone)';
  }
}
