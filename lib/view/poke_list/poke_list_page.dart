import 'package:flutter/material.dart';
import 'poke_list.dart';

class PokeListPage extends StatefulWidget {
  const PokeListPage({Key? key}) : super(key: key);

  @override
  _PokeListPageState createState() => _PokeListPageState();
}

class _PokeListPageState extends State<PokeListPage> {
  int currentbnb = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: currentbnb == 0
            ? const PokeList(isFavoriteMode: false)
            : const PokeList(isFavoriteMode: true),
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
            label: 'all',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome_outlined),
            label: 'favorite',
          ),
        ],
      ),
    );
  }
}
