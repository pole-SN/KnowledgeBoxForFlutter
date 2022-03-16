import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_mode_selection/theme_mode_selection_page.dart';
import '../../view_model/theme_mode_notifier.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModeNotifier>(
      builder: (context, mode, child) => ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.lightbulb),
            title: const Text('Dark/Light Mode'),
            trailing: Text((mode.mode == ThemeMode.system)
                ? 'System'
                : (mode.mode == ThemeMode.dark ? 'Dark' : 'Light')),
            onTap: () async {
              var ret = await Navigator.of(context).push<ThemeMode>(
                MaterialPageRoute(
                  builder: (context) => ThemeModeSelectionPage(mode: mode.mode),
                ),
              );
              if (ret != null) {
                mode.update(ret);
              }
            },
          ),
        ],
      ),
    );
  }
}
