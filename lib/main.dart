import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ui/top/top_page.dart';
import 'ui/poke_api/poke_list/poke_list_page.dart';
import 'ui/todo/todo_list/todo_list_page.dart';
import 'ui/settings/theme_mode_selection/theme_mode_selection_page.dart';
import 'view_model/settings/theme_mode_notifier.dart';
import 'view_model/poke_api/pokemons_notifier.dart';
import 'view_model/poke_api/favorites_notifier.dart';
import 'view_model/todo/todos_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences pref = await SharedPreferences.getInstance();
  final themeModeNotifier = ThemeModeNotifier(pref);
  final pokemonsNotifier = PokemonsNotifier();
  final favoritesNotifier = FavoritesNotifier();
  final todosNotifier = TodosNotifier();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeModeNotifier>(
          create: (context) => themeModeNotifier,
        ),
        ChangeNotifierProvider<PokemonsNotifier>(
          create: (context) => pokemonsNotifier,
        ),
        ChangeNotifierProvider<FavoritesNotifier>(
          create: (context) => favoritesNotifier,
        ),
        ChangeNotifierProvider<TodosNotifier>(
          create: (context) => todosNotifier,
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
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: mode.mode,
        home: const KnowledgeHomePage(title: 'Knowledge Box'),
        routes: <String, WidgetBuilder>{
          '/todolist': (context) => new TodoListPage(),
          '/pokelist': (context) => new PokeListPage(),
          '/themeselection': (context) =>
              new ThemeModeSelectionPage(mode: mode.mode),
        },
      ),
    );
  }
}
