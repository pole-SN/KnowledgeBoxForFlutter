import 'package:flutter/material.dart';
import 'settings.dart';

class KnowledgeHomePage extends StatefulWidget {
  const KnowledgeHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _KnowledgeHomePageState createState() => _KnowledgeHomePageState();
}

class _KnowledgeHomePageState extends State<KnowledgeHomePage> {
  String _title = "";
  int currentbnb = 0;

  @override
  void initState() {
    super.initState();
    _title = widget.title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: SafeArea(
        child: currentbnb == 0
            ? ListView(
                children: [
                  _menuItem(context, "Todo tool",
                      Icon(Icons.check_box_outlined), "/todolist"),
                  _menuItem(context, "Poke API", Icon(Icons.api), "/pokelist"),
                  _menuItem(context, "メニュー3", Icon(Icons.room), "TBD"),
                  _menuItem(context, "メニュー4", Icon(Icons.room), "TBD"),
                  _menuItem(context, "メニュー5", Icon(Icons.room), "TBD"),
                ],
              )
            : const Settings(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => {
          setState(
            () => currentbnb = index,
          )
        },
        currentIndex: currentbnb,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'settings',
          ),
        ],
      ),
    );
  }

  Widget _menuItem(
      BuildContext context, String title, Icon icon, String route) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: new BoxDecoration(
            border:
                new Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10.0),
              child: icon,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).pushNamed(route);
      },
    );
  }
}
