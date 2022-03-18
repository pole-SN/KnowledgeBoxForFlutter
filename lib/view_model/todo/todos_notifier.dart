import 'package:flutter/material.dart';
import '../../model/todo/todo.dart';
import '../../repository/todo/todos_crud.dart';

class TodosNotifier extends ChangeNotifier {
  final List<Todo> _todos = [];
  int navIndex = 0;

  List<Todo> get todos => _todos;

  TodosNotifier() {
    syncDb(navIndex);
  }

  void changeNav(int index) {
    navIndex = index;
    syncDb(navIndex);
  }

  void changeState(Todo todo) {
    update(
      Todo(
        todoId: todo.todoId,
        title: todo.title,
        isCompleted: todo.isCompleted == 0 ? 1 : 0,
        createdAt: todo.createdAt,
        updatedAt: DateTime.now(),
      ),
    );
  }

  void syncDb(int navIndex) async {
    await TodosCURD.read(navIndex).then(
      (val) => _todos
        ..clear()
        ..addAll(val),
    );
    notifyListeners();
  }

  void add(Todo todo) async {
    await TodosCURD.create(todo);
    syncDb(navIndex);
  }

  void update(Todo todo) async {
    await TodosCURD.update(todo);
    syncDb(navIndex);
  }

  void delete(int todoId) async {
    await TodosCURD.delete(todoId);
    syncDb(navIndex);
  }
}
