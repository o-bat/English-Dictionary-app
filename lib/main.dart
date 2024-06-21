import 'package:dynamic_color/dynamic_color.dart';
import 'package:english_dictionary/screens/home_screen.dart';
import 'package:english_dictionary/screens/saved.dart';
import 'package:english_dictionary/screens/settings.dart';
import 'package:english_dictionary/widgets/theme_blue.dart';
import 'package:english_dictionary/widgets/theme_green.dart';
import 'package:english_dictionary/widgets/util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

ThemeMode themeMode = ThemeMode.system;

void main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}

GoRouter router = GoRouter(routes: [
  GoRoute(
    path: "/",
    builder: (context, state) => const App(),
  ),
  GoRoute(
    path: "/Settings",
    builder: (context, state) => const Settings(),
  )
]);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

int index = 0;

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "ABeeZee", "ABeeZee");
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    MaterialThemeBlue theme = MaterialThemeBlue(textTheme);
    return MaterialApp(
      themeMode: themeMode,
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      home: const App(),
    );
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dictionary", style: TextStyle(fontSize: 36)),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Settings()));
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) {
          setState(() {
            index = value;
          });
        },
        destinations: const [
          NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: "Home"),
          NavigationDestination(
              selectedIcon: Icon(Icons.bookmark),
              icon: Icon(Icons.bookmark_border),
              label: "Saved"),
        ],
      ),
      body: index == 0 ? const HomePage() : const Saved(),
    );
  }
}
