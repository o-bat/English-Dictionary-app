import 'dart:async';
import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<Map<String, String>> words = [];

Future<void> saveTheWords(String word, String definition) async {
  var box = await Hive.openBox('savedWords');
  List<Map<dynamic, dynamic>>? words =
      box.get('words')?.cast<Map<dynamic, dynamic>>() ?? [];

  // Remove any existing word with the same ID
  words!.removeWhere((item) => item["id"] == word);

  // Add the new word
  words.add({"id": word, "def": definition});

  await box.put("words", words);

  await box.close();
}

Future<List<Map<dynamic, dynamic>>> getData() async {
  var box = await Hive.openBox('savedWords');
  List<dynamic>? name = box.get('words');

  return name != null ? List<Map<dynamic, dynamic>>.from(name) : [];
}

Future<void> removeData(String word, String definition) async {
  Box box;
  try {
    box = await Hive.openBox('savedWords');
    List<Map<dynamic, dynamic>>? words =
        box.get('words')?.cast<Map<dynamic, dynamic>>();

    if (words != null) {
      words.removeWhere(
          (item) => item["id"] == word && item["def"] == definition);
      await box.put('words', words);
    }
  } catch (e) {
    log('Error removing data: $e');
  }
}

Future<bool> isItOnList(String theWord) async {
  Box box;
  try {
    box = await Hive.openBox('savedWords');
    List<Map<dynamic, dynamic>>? words =
        box.get('words')?.cast<Map<dynamic, dynamic>>();

    if (words != null) {
      bool isOnList = words.any((item) => item["id"] == theWord);
      log('Is "$theWord" on list: $isOnList');
      return isOnList;
    }
  } catch (e) {
    log('Error checking list: $e');
  }

  return false;
}

Future<void> saveThePast(String word) async {
  var box = await Hive.openBox('savedWords');
  List<String> words = List<String>.from(box.get('Past') ?? []);

  // Add the new word
  words.add(word);

  await box.put("Past", words);
}

Future<List<String>> getPastData() async {
  var box = await Hive.openBox('savedWords');
  List<String> words = List<String>.from(box.get('Past') ?? []);

  return words;
}
