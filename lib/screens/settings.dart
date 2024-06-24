import 'package:english_dictionary/components/provider.dart';
import 'package:english_dictionary/components/theme_blue.dart';
import 'package:english_dictionary/components/theme_red.dart';
import 'package:english_dictionary/components/theme_yellow.dart';
import 'package:english_dictionary/services/local_save.dart';

import 'package:english_dictionary/components/theme_green.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

MaterialThemeBlue blueTheme = const MaterialThemeBlue();
MaterialThemeGreen greenTheme = const MaterialThemeGreen();
MaterialThemeRed redTheme = const MaterialThemeRed();
MaterialThemeYellow yellowTheme = const MaterialThemeYellow();

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Theme Settings",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Card(
              child: Column(children: [
                ListTile(
                  trailing: Text(
                    context.watch<ThemeModeProvider>().mode.name,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  title: const Text("Theme"),
                  onTap: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Select Theme'),
                      actions: <Widget>[
                        Card(
                          child: Column(
                            children: [
                              ListTile(
                                trailing: context
                                            .watch<ThemeModeProvider>()
                                            .mode
                                            .name ==
                                        "system"
                                    ? const Icon(Icons.task_alt)
                                    : const Icon(Icons.radio_button_unchecked),
                                title: const Text("System"),
                                onTap: () {
                                  context
                                      .read<ThemeModeProvider>()
                                      .changeThemeMode(
                                          newMode: ThemeMode.system);
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                trailing: context
                                            .watch<ThemeModeProvider>()
                                            .mode
                                            .name ==
                                        "dark"
                                    ? const Icon(Icons.task_alt)
                                    : const Icon(Icons.radio_button_unchecked),
                                onTap: () {
                                  context
                                      .read<ThemeModeProvider>()
                                      .changeThemeMode(newMode: ThemeMode.dark);
                                  Navigator.pop(context);
                                },
                                title: const Text("Dark"),
                              ),
                              ListTile(
                                trailing: context
                                            .watch<ThemeModeProvider>()
                                            .mode
                                            .name ==
                                        "light"
                                    ? const Icon(Icons.task_alt)
                                    : const Icon(Icons.radio_button_unchecked),
                                onTap: () {
                                  context
                                      .read<ThemeModeProvider>()
                                      .changeThemeMode(
                                          newMode: ThemeMode.light);
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
                ListTile(
                  trailing: Icon(
                    Icons.circle,
                    color: Theme.of(context).colorScheme.primary,
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
                                trailing: Icon(
                                  Icons.circle,
                                  color: blueTheme.light().primaryColor,
                                ),
                                selected: context
                                            .watch<ColorThemeProviderLight>()
                                            .data ==
                                        blueTheme.light() ||
                                    context
                                            .watch<ColorThemeProviderDark>()
                                            .data ==
                                        blueTheme.dark(),
                                title: const Text("Blue"),
                                onTap: () {
                                  context
                                      .read<ColorThemeProviderDark>()
                                      .changeThemeMode(
                                          newData: blueTheme.dark());
                                  context
                                      .read<ColorThemeProviderLight>()
                                      .changeThemeMode(
                                          newData: blueTheme.light());
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                trailing: Icon(
                                  Icons.circle,
                                  color: greenTheme.light().primaryColor,
                                ),
                                selected: context
                                            .watch<ColorThemeProviderLight>()
                                            .data ==
                                        greenTheme.light() ||
                                    context
                                            .watch<ColorThemeProviderDark>()
                                            .data ==
                                        greenTheme.dark(),
                                title: const Text("Green"),
                                onTap: () {
                                  context
                                      .read<ColorThemeProviderDark>()
                                      .changeThemeMode(
                                          newData: greenTheme.dark());
                                  context
                                      .read<ColorThemeProviderLight>()
                                      .changeThemeMode(
                                          newData: greenTheme.light());
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                trailing: Icon(
                                  Icons.circle,
                                  color: redTheme.light().primaryColor,
                                ),
                                selected: context
                                            .watch<ColorThemeProviderLight>()
                                            .data ==
                                        redTheme.light() ||
                                    context
                                            .watch<ColorThemeProviderDark>()
                                            .data ==
                                        redTheme.dark(),
                                title: const Text("Red"),
                                onTap: () {
                                  context
                                      .read<ColorThemeProviderDark>()
                                      .changeThemeMode(
                                          newData: redTheme.dark());
                                  context
                                      .read<ColorThemeProviderLight>()
                                      .changeThemeMode(
                                          newData: redTheme.light());
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                trailing: Icon(
                                  Icons.circle,
                                  color: yellowTheme.light().primaryColor,
                                ),
                                selected: context
                                            .watch<ColorThemeProviderLight>()
                                            .data ==
                                        yellowTheme.light() ||
                                    context
                                            .watch<ColorThemeProviderDark>()
                                            .data ==
                                        yellowTheme.dark(),
                                title: const Text("Yellow"),
                                onTap: () {
                                  context
                                      .read<ColorThemeProviderDark>()
                                      .changeThemeMode(
                                          newData: yellowTheme.dark());
                                  context
                                      .read<ColorThemeProviderLight>()
                                      .changeThemeMode(
                                          newData: yellowTheme.light());
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "History",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Card(
              child: ListTile(
                trailing: TextButton(
                    onPressed: () {
                      Provider.of<PastDataProvider>(context, listen: false)
                          .removePastData();
                    },
                    child: const Text("Clear")),
                title: const Text("Clear History"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
