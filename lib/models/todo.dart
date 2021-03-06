import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  final String title;
  final String description;
  final String imageUrl;

  Todo({
    this.title,
    this.description,
    this.imageUrl,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }

  factory Todo.fromFirebase(DocumentSnapshot doc) {
    Map data = doc.data();
    return Todo(
      title: data['title'],
      description: data['description'],
      imageUrl: data['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'description': this.description,
      'imageUrl': this.imageUrl
    };
  }
}

class TodoList {
  List<Todo> todos;

  TodoList(this.todos);

  factory TodoList.fromJson(List<dynamic> json) {
    List<Todo> todoList =
        json.map((x) => Todo.fromJson(x)).toList();

    return TodoList(todoList);
  }
}
