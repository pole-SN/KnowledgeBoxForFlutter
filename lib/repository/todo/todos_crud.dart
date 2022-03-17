import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../const/database.dart';
import '../../model/todo/todo.dart';

class TodosCURD {
  static Future<Database> openDb() async {
    return await openDatabase(
      join(await getDatabasesPath(), todoTableName),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $todoFileName(id INTEGER PRIMARY KEY, title TEXT, description TEXT, created_at TEXT, updated_at TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> create(Todo todo) async {
    var db = await openDb();
    await db.insert(
      todoFileName,
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> update(Todo todo) async {
    var db = await openDb();
    await db.update(
      todoFileName,
      todo.toMap(),
      where: "id = ?",
      whereArgs: [todo.todoId],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Todo>> read() async {
    var db = await openDb();
    final List<Map<String, dynamic>> maps = await db.query(todoFileName);
    return List.generate(maps.length, (index) {
      return Todo(
        todoId: maps[index]['id'],
        title: maps[index]['title'],
        description: maps[index]['description'],
        createdAt: maps[index]['createdAt'],
        updatedAt: maps[index]['updatedAt'],
      );
    });
  }

  static Future<void> delete(int todoId) async {
    var db = await openDb();
    await db.delete(
      todoFileName,
      where: 'id = ?',
      whereArgs: [todoId],
    );
  }
}
