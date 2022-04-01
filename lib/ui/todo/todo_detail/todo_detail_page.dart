import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:intl/intl.dart";
import '../../../model/todo/todo.dart';
import '../../../view_model/todo/todos_notifier.dart';
import '../../../const/datetime.dart';

class TodoDetailPage extends StatefulWidget {
  const TodoDetailPage({Key? key, required this.notifier, required this.index})
      : super(key: key);
  final TodosNotifier notifier;
  final int index;

  @override
  _TodoDetailPageState createState() => _TodoDetailPageState();
}

class _TodoDetailPageState extends State<TodoDetailPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  late Todo _todo;
  late int _index;
  late int _id;

  @override
  void initState() {
    super.initState();

    _index = widget.index;
    _todo = widget.notifier.todos[_index];
    _id = widget.notifier.todos[_index].todoId!;

    _titleController.text = _todo.title;

    if (_todo.description == null) {
      _descController.text = "";
    } else {
      _descController.text = _todo.description!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodosNotifier>(
      builder: (context, notifier, child) => Scaffold(
        appBar: AppBar(
          title: const Text(
            "Edit Todo",
          ),
          backgroundColor: Colors.black.withOpacity(0.2),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Card(
                color: const Color.fromARGB(255, 235, 235, 235),
                child: ListTile(
                  title: TextFormField(
                    autofocus: false,
                    controller: _titleController,
                    style: _titleController.text == notifier.getTodo(_id).title
                        ? const TextStyle(color: Colors.black)
                        : const TextStyle(color: Colors.red),
                    decoration: const InputDecoration(
                      labelText: 'タイトル',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                  trailing: _titleController.text == notifier.getTodo(_id).title
                      ? const IconButton(
                          icon: Icon(Icons.save_rounded),
                          onPressed: null,
                        )
                      : IconButton(
                          icon: const Icon(Icons.save_as_rounded,
                              color: Colors.green),
                          onPressed: () => {
                            if (_titleController.text.isNotEmpty &&
                                (_titleController.text !=
                                    notifier.getTodo(_id).title))
                              {
                                notifier.update(
                                  Todo(
                                    todoId: notifier.getTodo(_id).todoId,
                                    title: _titleController.text,
                                    description:
                                        notifier.getTodo(_id).description,
                                    isCompleted:
                                        notifier.getTodo(_id).isCompleted,
                                    createdAt: notifier.getTodo(_id).createdAt,
                                    updatedAt: DateTime.now(),
                                    deleting: 0,
                                  ),
                                ),
                              }
                          },
                        ),
                ),
              ),
              Card(
                color: const Color.fromARGB(255, 235, 235, 235),
                child: ListTile(
                  title: TextFormField(
                    autofocus: false,
                    controller: _descController,
                    style: _descController.text ==
                            notifier.getTodo(_id).description
                        ? const TextStyle(color: Colors.black)
                        : const TextStyle(color: Colors.red),
                    decoration: const InputDecoration(
                      labelText: '詳細',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                  trailing: _descController.text == "" ||
                          _descController.text ==
                              notifier.getTodo(_id).description
                      ? const IconButton(
                          icon: Icon(Icons.save_rounded),
                          onPressed: null,
                        )
                      : IconButton(
                          icon: const Icon(Icons.save_as_rounded,
                              color: Colors.green),
                          onPressed: () => {
                            if (_descController.text.isNotEmpty &&
                                (_descController.text !=
                                    notifier.getTodo(_id).description))
                              {
                                notifier.update(
                                  Todo(
                                    todoId: notifier.getTodo(_id).todoId,
                                    title: notifier.getTodo(_id).title,
                                    description: _descController.text,
                                    createdAt: notifier.getTodo(_id).createdAt,
                                    updatedAt: DateTime.now(),
                                    isCompleted:
                                        notifier.getTodo(_id).isCompleted,
                                    deleting: 0,
                                  ),
                                ),
                              }
                          },
                        ),
                ),
              ),
              Card(
                color: const Color.fromARGB(255, 235, 235, 235),
                child: ListTile(
                  title: const Text("Completed"),
                  trailing: IconButton(
                    icon: notifier.getTodo(_id).isCompleted == 0
                        ? const Icon(Icons.check_box_outline_blank)
                        : const Icon(Icons.check_box_outlined,
                            color: Colors.green),
                    onPressed: () => {
                      notifier.changeState(notifier.getTodo(_id)),
                    },
                  ),
                ),
              ),
              Card(
                color: const Color.fromARGB(255, 235, 235, 235),
                child: ListTile(
                  title: const Text("作成日時"),
                  subtitle: Text(
                    DateFormat(df).format(notifier.getTodo(_id).createdAt!),
                  ),
                ),
              ),
              Card(
                color: const Color.fromARGB(255, 235, 235, 235),
                child: ListTile(
                  title: const Text("更新日時"),
                  subtitle: Text(
                    DateFormat(df).format(notifier.getTodo(_id).updatedAt!),
                  ),
                ),
              ),
              Card(
                color: const Color.fromARGB(255, 244, 53, 53),
                child: ListTile(
                  title: const Text(
                    "Todoを削除",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () => {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) {
                        return AlertDialog(
                          title: const Text("Todoを削除しますか？"),
                          content: const Text("削除すると元に戻すことはできません。"),
                          actions: [
                            TextButton(
                              child: const Text("キャンセル"),
                              onPressed: () => Navigator.pop(context),
                            ),
                            TextButton(
                              child: const Text("削除"),
                              onPressed: () => {
                                notifier.update(
                                  Todo(
                                    todoId: notifier.getTodo(_id).todoId,
                                    title: notifier.getTodo(_id).title,
                                    description:
                                        notifier.getTodo(_id).description,
                                    createdAt: notifier.getTodo(_id).createdAt,
                                    updatedAt: DateTime.now(),
                                    isCompleted:
                                        notifier.getTodo(_id).isCompleted,
                                    deleting: 1,
                                  ),
                                ),
                                Future.delayed(
                                  const Duration(seconds: 2),
                                  () {
                                    notifier.delete(_id);
                                  },
                                ),
                                Navigator.pop(context),
                                Navigator.pop(context),
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
