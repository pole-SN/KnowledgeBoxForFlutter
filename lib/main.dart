import 'package:flutter/material.dart';
import 'view/top/top_page.dart';
import 'view/poke_list/poke_list_page.dart';
import 'view/theme_mode_selection/theme_mode_selection_page.dart';
import 'view_model/theme_mode_notifier.dart';
import 'view_model/pokemons_notifier.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences pref = await SharedPreferences.getInstance();
  final themeModeNotifier = ThemeModeNotifier(pref);
  final pokemonsNotifier = PokemonsNotifier();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeModeNotifier>(
          create: (context) => themeModeNotifier,
        ),
        ChangeNotifierProvider<PokemonsNotifier>(
          create: (context) => pokemonsNotifier,
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModeNotifier>(
      builder: (context, mode, child) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: mode.mode,
        home: const KnowledgeHomePage(title: 'Knowledge Box'),
        routes: <String, WidgetBuilder>{
          '/pokelist': (context) => new PokeListPage(),
          '/themeselection': (context) =>
              new ThemeModeSelectionPage(mode: mode.mode),
        },
      ),
    );
  }
}
