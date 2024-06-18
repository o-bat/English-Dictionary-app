import 'dart:async';
import 'dart:developer';

import 'package:hive/hive.dart';

List<Map<String, String>> words = [];

void saveTheWords(String word, String definition) async {
  var box = await Hive.openBox('savedWords');

  words.add({"id": word, "def": definition});
  await box.put("words", words);

  log('Saved words: ${box.get('words')}');

  await box.close();
}

Future<List<Map<dynamic, dynamic>>> getData() async {
  var box = await Hive.openBox('savedWords');
  List<dynamic>? name = box.get('words');
  await box.close();

  log('Retrieved words: $name');
  return name != null ? List<Map<dynamic, dynamic>>.from(name) : [];
}

void removeData(String word, String definition) async {
  var box = await Hive.openBox('savedWords');
  List<dynamic>? name = box.get('words');

  if (name != null) {
    name.removeWhere((item) => item["id"] == word && item["def"] == definition);
    await box.put("words", name);
  }

  await box.close();
}

Future<bool> isItOnList(String theWord) async {
  var box = await Hive.openBox('savedWords');
  List<dynamic>? name = box.get('words');
  await box.close();

  if (name != null) {
    List<String> wordIds = name.map((item) => item["id"] as String).toList();
    bool isOnList = wordIds.contains(theWord);
    log('Is "$theWord" on list: $isOnList');
    return isOnList;
  }

  log('Is "$theWord" on list: false');
  return false;
}





/*import 'dart:async';

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

void removeData(String word, String definition) async {
  var box = await Hive.openBox('savedWords');
  List<dynamic> name = box.get('words');

  name.remove({"id": word, "def": definition});

  box.put("words", name);
}

Future<bool> isItOnList(String theword) async {
  var box = await Hive.openBox('savedWords');

  List<dynamic>? name = box.get('words');

  for (var i = 0; i < name!.length; i++) {
    List<String> words = [];
    words.add(name[i]["id"]);
  }
  log(words.contains(theword).toString());
  return !words.contains(theword) ? false : true;
}*/
