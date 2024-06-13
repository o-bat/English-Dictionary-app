import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

class Word extends StatefulWidget {
  const Word({super.key});

  @override
  State<Word> createState() => _WordState();
}

class _WordState extends State<Word> {
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
