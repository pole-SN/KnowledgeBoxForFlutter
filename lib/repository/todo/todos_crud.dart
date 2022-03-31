import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../const/database.dart';
import '../../model/todo/todo.dart';
import "package:intl/intl.dart";
import '../../const/datetime.dart';

class TodosCURD {
  static Future<Database> openDb() async {
    return await openDatabase(
      join(await getDatabasesPath(), todoFileName),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $todoTableName(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, is_completed INTEGER, created_at TEXT, updated_at TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> create(Todo todo) async {
    var db = await openDb();
    await db.insert(
      todoTableName,
      todo.createDataToMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> update(Todo todo) async {
    var db = await openDb();
    await db.update(
      todoTableName,
      todo.updateDataToMap(),
      where: "id = ?",
      whereArgs: [todo.todoId],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Todo>> read() async {
    var db = await openDb();
    final List<Map<String, dynamic>> maps = await _getQuery(db);
    return List.generate(
      maps.length,
      (index) {
        return Todo(
          todoId: maps[index]['id'],
          title: maps[index]['title'],
          description: maps[index]['description'],
          isCompleted: maps[index]['is_completed'],
          createdAt: DateFormat(df).parseStrict(maps[index]['created_at']),
          updatedAt: DateFormat(df).parseStrict(maps[index]['updated_at']),
        );
      },
    );
  }

  static _getQuery(db) {
    return db.query(
      todoTableName,
      orderBy: "id DESC",
    );
  }

  static Future<void> delete(int todoId) async {
    var db = await openDb();
    await db.delete(
      todoTableName,
      where: 'id = ?',
      whereArgs: [todoId],
    );
  }
}
