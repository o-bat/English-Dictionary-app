import 'package:dynamic_color/dynamic_color.dart';
import 'package:english_dictionary/screens/home_screen.dart';
import 'package:english_dictionary/screens/saved.dart';
import 'package:english_dictionary/screens/settings.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

void main() {
  runApp(const MyApp());
}

CustomColors lightCustomColors = const CustomColors(danger: Color(0xFFE53935));
CustomColors darkCustomColors = const CustomColors(danger: Color(0xFFEF9A9A));
const _brandBlue = Color(0xFF1E88E5);
bool _isDemoUsingDynamicColors = false;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

int index = 0;

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
      return MaterialApp(
        theme: Platform.isAndroid == true
            ? ThemeData(
                colorScheme: lightDynamic,
                extensions: [lightCustomColors],
              )
            : ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.green,
                ),
              ),
        darkTheme: Platform.isAndroid == true
            ? ThemeData(
                brightness: Brightness.dark,
                colorScheme: darkDynamic,
                extensions: [darkCustomColors],
              )
            : ThemeData(
                brightness: Brightness.dark,
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.green,
                  brightness: Brightness.dark,
                ),
              ),
        home: Scaffold(
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
              NavigationDestination(
                  selectedIcon: Icon(Icons.settings),
                  icon: Icon(Icons.settings_outlined),
                  label: "Settings"),
            ],
          ),
          body: index == 0
              ? const HomePage()
              : index == 1
                  ? const Saved()
                  : const Settings(),
        ),
      );
    });
  }
}

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.danger,
  });

  final Color? danger;

  @override
  CustomColors copyWith({Color? danger}) {
    return CustomColors(
      danger: danger ?? this.danger,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      danger: Color.lerp(danger, other.danger, t),
    );
  }

  CustomColors harmonized(ColorScheme dynamic) {
    return copyWith(danger: danger!.harmonizeWith(dynamic.primary));
  }
}
