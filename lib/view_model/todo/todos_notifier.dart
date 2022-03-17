import 'package:flutter/material.dart';
import '../../model/todo/todo.dart';
import '../../repository/todo/todos_crud.dart';

class TodosNotifier extends ChangeNotifier {
  final List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  TodosNotifier() {
    syncDb();
  }

  void syncDb() async {
    TodosCURD.read().then(
      (val) => _todos
        ..clear()
        ..addAll(val),
    );
    notifyListeners();
  }

  void add(Todo todo) async {
    await TodosCURD.create(todo);
    syncDb();
  }

  void update(Todo todo) async {
    await TodosCURD.update(todo);
    syncDb();
  }

  void delete(int todoId) async {
    await TodosCURD.delete(todoId);
    syncDb();
  }
}
