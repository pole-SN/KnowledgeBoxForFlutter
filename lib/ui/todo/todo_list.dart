import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_model/todo/todos_notifier.dart';
import '../../model/todo/todo.dart';
import "package:intl/intl.dart";
import 'package:intl/date_symbol_data_local.dart';
import '../../const/datetime.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key, required this.navIndex}) : super(key: key);

  final int navIndex;

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  int _navIndex = 0;
  final TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _navIndex = widget.navIndex;
    initializeDateFormatting('ja_JP');
  }

  @override
  didUpdateWidget(Widget oldWidget) {
    _navIndex = widget.navIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodosNotifier>(
      builder: (context, notifier, child) => Column(
        children: [
          ListTile(
            title: TextFormField(
              autofocus: false,
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: '新しいTodoを作成する',
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.create, color: Colors.green),
              onPressed: () => {
                if (_titleController.text.isNotEmpty)
                  {
                    notifier.add(
                      Todo(
                        title: _titleController.text,
                        isCompleted: 0,
                        createdAt: DateTime.now(),
                      ),
                    ),
                    _titleController.text = "",
                  },
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              itemCount: notifier.todos.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    isThreeLine: true,
                    title: notifier.todos[index].isCompleted == 0
                        ? Text(notifier.todos[index].title)
                        : Text(
                            notifier.todos[index].title,
                            style: const TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                    subtitle: Text(
                      "作成日時：" +
                          DateFormat(df)
                              .format(notifier.todos[index].createdAt!) +
                          "\n" +
                          "更新日時：" +
                          DateFormat(df)
                              .format(notifier.todos[index].updatedAt!),
                    ),
                    trailing: IconButton(
                      icon: notifier.todos[index].isCompleted == 0
                          ? const Icon(Icons.check_box_outline_blank)
                          : const Icon(Icons.check_box_outlined,
                              color: Colors.green),
                      onPressed: () => {
                        notifier.changeState(notifier.todos[index]),
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
