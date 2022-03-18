import "package:intl/intl.dart";
import 'package:intl/date_symbol_data_local.dart';
import '../../const/datetime.dart';

class Todo {
  final int? todoId;
  final String title;
  final String? description;
  final int isCompleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Todo({
    this.todoId,
    required this.title,
    this.description,
    required this.isCompleted,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> createDataToMap() {
    initializeDateFormatting("ja_JP");
    return {
      'id': todoId,
      'title': title,
      'description': description,
      'is_completed': isCompleted,
      'created_at': DateFormat(df).format(DateTime.now()),
      'updated_at': DateFormat(df).format(DateTime.now()),
    };
  }

  Map<String, dynamic> updateDataToMap() {
    initializeDateFormatting("ja_JP");
    return {
      'id': todoId,
      'title': title,
      'description': description,
      'is_completed': isCompleted,
      'created_at': DateFormat(df).format(createdAt!),
      'updated_at': DateFormat(df).format(updatedAt!),
    };
  }
}
