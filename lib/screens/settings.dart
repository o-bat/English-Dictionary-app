import 'package:dynamic_color/dynamic_color.dart';
import 'package:english_dictionary/main.dart';
import 'package:english_dictionary/services/local_save.dart';
import 'package:english_dictionary/widgets/theme_blue.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

List<Color> themeColors = [
  const Color(0xff415f91),
  const Color(0xff4c662b),
  const Color(0xff8f4c38),
  const Color(0xff6d5e0f),
];

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        body: Column(
          children: [
            Card(
              child: ListTile(
                title: const Text("Color Theme"),
                trailing: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MenuAnchor(
                      menuChildren: List<Widget>.generate(4, (int index) {
                        return MenuItemButton(
                          leadingIcon: Icon(
                            Icons.circle,
                            color: themeColors[index],
                          ),
                          child: const Text("data"),
                        );
                      }),
                      builder: (BuildContext context, MenuController controller,
                          Widget? widget) {
                        return IconButton(
                          icon: const Icon(
                            Icons.circle,
                          ),
                          onPressed: () {
                            setState(() {
                              if (!controller.isOpen) {
                                controller.open();
                              }
                            });
                          },
                        );
                      }),
                ),
              ),
            )
          ],
        ));
  }
}
