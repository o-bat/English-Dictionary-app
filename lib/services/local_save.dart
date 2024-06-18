import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:hive/hive.dart';

List<dynamic> words = [{}];
void saveTheWords(String word, String definition) async {
  var box = await Hive.openBox('savedWords');

  words.add({"id": word, "def": definition});

  box.put("words", words);

  var name = box.get('words');

  log(name);
}

Future<List<dynamic>> getData() async {
  var box = await Hive.openBox('savedWords');

  List<dynamic> name = box.get('words');
  log(name.toString());
  return name;
}
