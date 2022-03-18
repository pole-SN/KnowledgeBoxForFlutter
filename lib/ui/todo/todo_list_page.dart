import 'package:flutter/material.dart';
import 'todo_list.dart';
import '../../view_model/todo/todos_notifier.dart';
import 'package:provider/provider.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  int navIndex = 0;

  @override
  Widget build(BuildContext context) {
    final todo = Provider.of<TodosNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Todo List",
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.grey.withOpacity(0.2),
          child: TodoList(navIndex: navIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => {
          todo.changeNav(index),
          setState(
            () => navIndex = index,
          )
        },
        currentIndex: navIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'All',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box_outlined),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box_outline_blank),
            label: 'Incomplete',
          ),
        ],
      ),
    );
  }
}
