import 'package:dynamic_color/dynamic_color.dart';
import 'package:english_dictionary/services/local_save.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Settings"),
          ),
        );
      },
    );
  }
}
