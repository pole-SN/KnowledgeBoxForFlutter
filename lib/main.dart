import 'package:flutter/material.dart';
import 'top_page.dart';
import 'poke_list_page.dart';
import 'theme_mode_selection_page.dart';
import 'shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    loadThemeMode().then((val) => setState(() => themeMode = val));
  }

  @override
  Widget build(BuildContext context) {
    ThemeMode mode = ThemeMode.system;
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: mode,
        home: const KnowledgeHomePage(title: 'Flutter Demo Home Page'),
        routes: <String, WidgetBuilder>{
          // '/my-page-1' : (BuildContext context) => new MyPage1(),
          '/pokelist': (BuildContext context) => new PokeListPage(),
          '/themeselection': (BuildContext context) =>
              new ThemeModeSelectionPage(mode: ThemeMode.system),
        });
  }
}
