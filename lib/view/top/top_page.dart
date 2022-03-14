import 'package:flutter/material.dart';

class KnowledgeHomePage extends StatelessWidget {
  const KnowledgeHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(children: [
        _menuItem(context, "Todo tool", Icon(Icons.settings), "todo"),
        _menuItem(context, "Poke API", Icon(Icons.api), "/pokelist"),
        _menuItem(context, "メニュー3", Icon(Icons.room), "todo"),
        _menuItem(context, "メニュー4", Icon(Icons.local_shipping), "todo"),
        _menuItem(context, "メニュー5", Icon(Icons.airplanemode_active), "todo"),
      ]),
    );
  }

  Widget _menuItem(
      BuildContext context, String title, Icon icon, String route) {
    return GestureDetector(
      child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: new BoxDecoration(
              border: new Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey))),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10.0),
                child: icon,
              ),
              Text(
                title,
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
            ],
          )),
      onTap: () {
        Navigator.of(context).pushNamed(route);
      },
    );
  }
}
