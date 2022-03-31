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
  late TodosNotifier _notifier;
  late Todo _todo;
  late int _index;
  late int _todoId;

  @override
  void initState() {
    super.initState();

    _notifier = widget.notifier;
    _index = widget.index;
    _todo = widget.notifier.todos[_index];
    _todoId = widget.notifier.todos[_index].todoId!;

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
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Card(
                color: Color.fromARGB(255, 235, 235, 235),
                child: ListTile(
                  title: TextFormField(
                    autofocus: false,
                    controller: _titleController,
                    style:
                        _titleController.text == notifier.getTodo(_todoId).title
                            ? const TextStyle(color: Colors.black)
                            : const TextStyle(color: Colors.red),
                    decoration: const InputDecoration(
                      labelText: 'タイトル',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                  trailing: _titleController.text ==
                          notifier.getTodo(_todoId).title
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
                                    notifier.getTodo(_todoId).title))
                              {
                                notifier.update(
                                  Todo(
                                    todoId: notifier.getTodo(_todoId).todoId,
                                    title: _titleController.text,
                                    description:
                                        notifier.getTodo(_todoId).description,
                                    createdAt:
                                        notifier.getTodo(_todoId).createdAt,
                                    updatedAt: DateTime.now(),
                                    isCompleted:
                                        notifier.getTodo(_todoId).isCompleted,
                                  ),
                                ),
                              }
                          },
                        ),
                ),
              ),
              Card(
                color: Color.fromARGB(255, 235, 235, 235),
                child: ListTile(
                  title: TextFormField(
                    autofocus: false,
                    controller: _descController,
                    style: _descController.text ==
                            notifier.getTodo(_todoId).description
                        ? const TextStyle(color: Colors.black)
                        : const TextStyle(color: Colors.red),
                    decoration: const InputDecoration(
                      labelText: '詳細',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                  trailing: _descController.text == "" ||
                          _descController.text ==
                              notifier.getTodo(_todoId).description
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
                                    notifier.getTodo(_todoId).description))
                              {
                                notifier.update(
                                  Todo(
                                    todoId: notifier.getTodo(_todoId).todoId,
                                    title: notifier.getTodo(_todoId).title,
                                    description: _descController.text,
                                    createdAt:
                                        notifier.getTodo(_todoId).createdAt,
                                    updatedAt: DateTime.now(),
                                    isCompleted:
                                        notifier.getTodo(_todoId).isCompleted,
                                  ),
                                ),
                              }
                          },
                        ),
                ),
              ),
              Card(
                color: Color.fromARGB(255, 235, 235, 235),
                child: ListTile(
                  title: const Text("Completed"),
                  trailing: IconButton(
                    icon: notifier.getTodo(_todoId).isCompleted == 0
                        ? const Icon(Icons.check_box_outline_blank)
                        : const Icon(Icons.check_box_outlined,
                            color: Colors.green),
                    onPressed: () => {
                      notifier.changeState(notifier.getTodo(_todoId)),
                    },
                  ),
                ),
              ),
              Card(
                color: Color.fromARGB(255, 235, 235, 235),
                child: ListTile(
                  title: const Text("作成日時"),
                  subtitle: Text(
                    DateFormat(df).format(notifier.getTodo(_todoId).createdAt!),
                  ),
                ),
              ),
              Card(
                color: Color.fromARGB(255, 235, 235, 235),
                child: ListTile(
                  title: const Text("更新日時"),
                  subtitle: Text(
                    DateFormat(df).format(notifier.getTodo(_todoId).updatedAt!),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
