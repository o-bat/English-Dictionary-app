import 'package:english_dictionary/components/theme_green.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeModeProvider extends ChangeNotifier {
  ThemeMode mode;

  ThemeModeProvider({required this.mode}) {
    _loadThemeMode();
  }

  // Load the theme mode from Hive storage when the provider is instantiated
  void _loadThemeMode() async {
    try {
      var box = await Hive.openBox('Settings');
      // Load the saved theme mode or default to system
      mode = box.get('ThemeMode', defaultValue: ThemeMode.system);
      notifyListeners();
    } catch (e) {
      // Handle errors if necessary
      print('Error loading theme mode: $e');
    }
  }

  // Change the theme mode and save it to Hive storage
  void changeThemeMode({required ThemeMode newMode}) async {
    try {
      var box = await Hive.openBox('Settings');
      mode = newMode;
      box.put('ThemeMode', mode);
      notifyListeners();
    } catch (e) {
      // Handle errors if necessary
      print('Error saving theme mode: $e');
    }
  }
}

class ColorThemeProviderLight extends ChangeNotifier {
  ThemeData data;
  ColorThemeProviderLight({required this.data}) {
    _loadThemeMode();
  }

  // Load the theme mode from Hive storage when the provider is instantiated
  void _loadThemeMode() async {
    try {
      MaterialThemeGreen theme = const MaterialThemeGreen();
      var box = await Hive.openBox('Settings');
      // Load the saved theme mode or default to system
      data = box.get('ColorThemeLight', defaultValue: theme.light());
      notifyListeners();
    } catch (e) {
      // Handle errors if necessary
      print('Error loading theme mode: $e');
    }
  }

  // Change the theme mode and save it to Hive storage
  void changeThemeMode({required ThemeData newData}) async {
    try {
      var box = await Hive.openBox('Settings');
      data = newData;
      box.put('ColorThemeLight', data);
      notifyListeners();
    } catch (e) {
      // Handle errors if necessary
      print('Error saving theme mode: $e');
    }
  }
}

class ColorThemeProviderDark extends ChangeNotifier {
  ThemeData data;
  ColorThemeProviderDark({required this.data}) {
    _loadThemeMode();
  }

  // Load the theme mode from Hive storage when the provider is instantiated
  void _loadThemeMode() async {
    try {
      MaterialThemeGreen theme = const MaterialThemeGreen();
      var box = await Hive.openBox('Settings');

      // Load the saved theme mode or default to system
      data = box.get('ColorThemeDark', defaultValue: theme.dark());
      notifyListeners();
    } catch (e) {
      // Handle errors if necessary
      print('Error loading theme mode: $e');
    }
  }

  // Change the theme mode and save it to Hive storage
  void changeThemeMode({required ThemeData newData}) async {
    try {
      var box = await Hive.openBox('Settings');
      data = newData;
      box.put('ColorThemeDark', data);
      notifyListeners();
    } catch (e) {
      // Handle errors if necessary
      print('Error saving theme mode: $e');
    }
  }
}

class PastDataProvider extends ChangeNotifier {
  List<String> past;
  PastDataProvider({required this.past}) {
    getPastData();
  }

  Future<void> saveThePast(String word) async {
    var box = await Hive.openBox('PastWords');
    List<String> words = List<String>.from(box.get('Past') ?? []);

    // Add the new word
    words.add(word);

    await box.put("Past", words);
    notifyListeners();
  }

  Future<List<String>> getPastData() async {
    var box = await Hive.openBox('PastWords');
    List<String> words = List<String>.from(box.get('Past') ?? []);

    return words;
  }

  void removePastData() async {
    var box = await Hive.openBox('PastWords');
    box.clear();
    notifyListeners();
  }
}
