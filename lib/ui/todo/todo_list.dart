import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_model/todo/todos_notifier.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key, required this.navIndex}) : super(key: key);

  final int navIndex;

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  static const int pageSize = 30;
  int _currentPage = 1;
  int _navIndex = 0;

  @override
  void initState() {
    super.initState();

    _navIndex = widget.navIndex;
  }

  @override
  didUpdateWidget(Widget oldWidget) {
    _navIndex = widget.navIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            "test",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          trailing: Container(
            child: const Icon(Icons.add_circle_outline),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            itemCount: 1000,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Container(
                  child: const Icon(Icons.settings),
                ),
                title: const Text(
                  "test",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
