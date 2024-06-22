import 'package:english_dictionary/services/local_save.dart';

import 'package:english_dictionary/widgets/theme_green.dart';

import 'package:english_dictionary/widgets/util.dart';
import 'package:flutter/material.dart';

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
      body: const Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                title: Text("Color Theme"),

              )
            ),
          ),
        ],
      ),
    );
  }
}
