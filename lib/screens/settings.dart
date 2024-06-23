import 'package:english_dictionary/components/provider.dart';
import 'package:english_dictionary/services/local_save.dart';

import 'package:english_dictionary/components/theme_green.dart';

import 'package:english_dictionary/components/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: ListTile(
              trailing: Text(
                context.watch<SettingsProvider>().mode.name,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              title: const Text("Color Theme"),
              onTap: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Select Color Theme'),
                  actions: <Widget>[
                    Card(
                      child: Column(
                        children: [
                          ListTile(
                            trailing:
                                context.watch<SettingsProvider>().mode.name ==
                                        "system"
                                    ? const Icon(Icons.task_alt)
                                    : const Icon(Icons.radio_button_unchecked),
                            title: const Text("System"),
                            onTap: () {
                              context
                                  .read<SettingsProvider>()
                                  .changeThemeMode(newMode: ThemeMode.system);
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            trailing:
                                context.watch<SettingsProvider>().mode.name ==
                                        "dark"
                                    ? const Icon(Icons.task_alt)
                                    : const Icon(Icons.radio_button_unchecked),
                            onTap: () {
                              context
                                  .read<SettingsProvider>()
                                  .changeThemeMode(newMode: ThemeMode.dark);
                              Navigator.pop(context);
                            },
                            title: const Text("Dark"),
                          ),
                          ListTile(
                            trailing:
                                context.watch<SettingsProvider>().mode.name ==
                                        "light"
                                    ? const Icon(Icons.task_alt)
                                    : const Icon(Icons.radio_button_unchecked),
                            onTap: () {
                              context
                                  .read<SettingsProvider>()
                                  .changeThemeMode(newMode: ThemeMode.light);
                              Navigator.pop(context);
                            },
                            title: const Text("Light"),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
