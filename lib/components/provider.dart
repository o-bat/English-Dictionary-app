import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode mode;

  SettingsProvider({required this.mode}) {
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
