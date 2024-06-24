import 'package:english_dictionary/components/adapter.dart';
import 'package:english_dictionary/components/provider.dart';
import 'package:english_dictionary/components/theme_green.dart';

import 'package:english_dictionary/screens/home_screen.dart';
import 'package:english_dictionary/screens/saved.dart';
import 'package:english_dictionary/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
// Import the adapter

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Register the adapter
  Hive.registerAdapter(ThemeModeAdapter());

  Hive.registerAdapter(DarkColorMode());
  Hive.registerAdapter(LightColorMode());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    MaterialThemeGreen theme = const MaterialThemeGreen();
    List<String> data = [];

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => PastDataProvider(past: data)),
        ChangeNotifierProvider(
          create: (context) => ColorThemeProviderDark(data: theme.dark()),
        ),
        ChangeNotifierProvider(
          create: (context) => ColorThemeProviderLight(data: theme.light()),
        ),
        ChangeNotifierProvider<ThemeModeProvider>(
          create: (context) => ThemeModeProvider(mode: ThemeMode.system),
        ),
      ],
      child: Consumer<ThemeModeProvider>(
        builder: (context, settingsProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: context.watch<ColorThemeProviderLight>().data,
            darkTheme: context.watch<ColorThemeProviderDark>().data,
            themeMode: settingsProvider.mode,
            home: const App(),
          );
        },
      ),
    );
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dictionary", style: TextStyle(fontSize: 36)),
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
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark),
            icon: Icon(Icons.bookmark_border),
            label: 'Saved',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
      body: index == 0
          ? const HomePage()
          : index == 1
              ? const Saved()
              : const Settings(),
    );
  }
}
