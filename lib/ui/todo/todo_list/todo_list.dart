import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:intl/intl.dart";
import 'package:intl/date_symbol_data_local.dart';
import '../../../view_model/todo/todos_notifier.dart';
import '../../../model/todo/todo.dart';
import '../../../const/datetime.dart';
import '../todo_detail/todo_detail_page.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final TextEditingController _titleController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    initializeDateFormatting('ja_JP');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodosNotifier>(
      builder: (context, notifier, child) => Column(
        children: [
          ListTile(
            title: TextFormField(
              autofocus: false,
              focusNode: _focusNode,
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
                if (notifier.getNavIndex() == 0 ||
                    (notifier.getNavIndex() == 1 &&
                        notifier.todos[index].isCompleted == 1) ||
                    (notifier.getNavIndex() == 2 &&
                        notifier.todos[index].isCompleted == 0)) {
                  return Card(
                    child: notifier.todos[index].deleting == 0
                        ? _normalListTile(notifier, index)
                        : _deletingListTile(notifier, index),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  ListTile _normalListTile(TodosNotifier notifier, int index) {
    return ListTile(
      isThreeLine: true,
      title: _getTitleWidget(notifier, index),
      subtitle: _getDateTimesWidget(notifier, index),
      trailing: IconButton(
        icon: notifier.todos[index].isCompleted == 0
            ? const Icon(Icons.check_box_outline_blank)
            : const Icon(Icons.check_box_outlined, color: Colors.green),
        onPressed: () => {
          notifier.changeState(notifier.todos[index]),
        },
      ),
      onTap: () => {
        _focusNode.unfocus(),
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => TodoDetailPage(
              notifier: notifier,
              index: index,
            ),
          ),
        ),
      },
    );
  }

  ListTile _deletingListTile(TodosNotifier notifier, int index) {
    return ListTile(
      tileColor: Colors.grey.withOpacity(0.6),
      isThreeLine: true,
      title: _getTitleWidget(notifier, index),
      subtitle: _getDateTimesWidget(notifier, index),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          SizedBox(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            ),
            height: 20.0,
            width: 20.0,
          ),
          Text(
            "削除中",
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }

  Text _getTitleWidget(TodosNotifier notifier, int index) {
    return notifier.todos[index].isCompleted == 0
        ? Text(notifier.todos[index].title)
        : Text(
            notifier.todos[index].title,
            style: const TextStyle(
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
            ),
          );
  }

  Text _getDateTimesWidget(TodosNotifier notifier, int index) {
    return Text(
      "作成日時：" +
          DateFormat(df).format(notifier.todos[index].createdAt!) +
          "\n" +
          "更新日時：" +
          DateFormat(df).format(notifier.todos[index].updatedAt!),
    );
  }
}
