import 'package:english_dictionary/components/theme_blue.dart';
import 'package:english_dictionary/components/theme_green.dart';
import 'package:english_dictionary/components/theme_red.dart';
import 'package:english_dictionary/components/theme_yellow.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeModeAdapter extends TypeAdapter<ThemeMode> {
  @override
  final typeId = 0;

  @override
  ThemeMode read(BinaryReader reader) {
    final value = reader.readInt();
    return ThemeMode.values[value]; // Handle unknown values
  }

  @override
  void write(BinaryWriter writer, ThemeMode obj) {
    writer.writeInt(obj.index);
  }
}

enum ThemeType { blue, green, red, yellow }

class LightColorMode extends TypeAdapter<ThemeData> {
  @override
  final typeId = 1;

  final Map<ThemeType, ThemeData Function()> _themeMap = {
    ThemeType.blue: () => const MaterialThemeBlue().light(),
    ThemeType.green: () => const MaterialThemeGreen().light(),
    ThemeType.red: () => const MaterialThemeRed().light(),
    ThemeType.yellow: () => const MaterialThemeYellow().light()
  };

  @override
  ThemeData read(BinaryReader reader) {
    final themeType = ThemeType.values[reader.readInt()];
    return _themeMap[themeType]?.call() ??
        ThemeData.light(); // Handle unknown themes
  }

  @override
  void write(BinaryWriter writer, ThemeData obj) {
    final matchingTheme = _themeMap.entries.firstWhere(
      (entry) => entry.value() == obj,
      orElse: () => _themeMap.entries.first,
    );
    writer.writeInt(matchingTheme.key.index); // Write -1 for unknown themes
  }
}

class DarkColorMode extends TypeAdapter<ThemeData> {
  @override
  final typeId = 2;

  final Map<ThemeType, ThemeData Function()> _themeMap = {
    ThemeType.blue: () => const MaterialThemeBlue().dark(),
    ThemeType.green: () => const MaterialThemeGreen().dark(),
    ThemeType.red: () => const MaterialThemeRed().dark(),
    ThemeType.yellow: () => const MaterialThemeYellow().dark()
  };

  @override
  ThemeData read(BinaryReader reader) {
    final themeType = ThemeType.values[reader.readInt()];
    return _themeMap[themeType]?.call() ??
        ThemeData.dark(); // Handle unknown themes
  }

  @override
  void write(BinaryWriter writer, ThemeData obj) {
    final matchingTheme = _themeMap.entries.firstWhere(
      (entry) => entry.value() == obj,
      orElse: () => _themeMap.entries.first,
    );
    writer.writeInt(matchingTheme.key.index); // Write -1 for unknown themes
  }
}
