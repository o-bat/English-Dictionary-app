import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

void SaveTheWords(String word) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final List<String>? words = prefs.getStringList('words');

  words!.add(word);
  log(words.toString());
  await prefs.setStringList('words', words);
}

Future<List<String>?> getTheWords() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final List<String>? words = prefs.getStringList('words');
  return words;
}
