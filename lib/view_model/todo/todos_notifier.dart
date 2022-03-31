import 'package:flutter/material.dart';
import '../../model/todo/todo.dart';
import '../../repository/todo/todos_crud.dart';

class TodosNotifier extends ChangeNotifier {
  final List<Todo> _todos = [];
  int _navIndex = 0;

  List<Todo> get todos => _todos;

  TodosNotifier() {
    syncDb();
  }

  Todo getTodo(int todoId) {
    return _todos.firstWhere((todo) => todo.todoId == todoId);
  }

  int getNavIndex() {
    return _navIndex;
  }

  void changeNav(int index) {
    _navIndex = index;
    syncDb();
  }

  void changeState(Todo todo) {
    update(
      Todo(
        todoId: todo.todoId,
        title: todo.title,
        description: todo.description,
        isCompleted: todo.isCompleted == 0 ? 1 : 0,
        createdAt: todo.createdAt,
        updatedAt: DateTime.now(),
      ),
    );
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

  void syncDb() async {
    await TodosCURD.read().then(
      (val) => _todos
        ..clear()
        ..addAll(val),
    );
    notifyListeners();
  }
}
