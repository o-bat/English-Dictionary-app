import 'dart:developer';

import 'package:english_dictionary/models/words.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<Word> getTheWord(String word) async {
  var response = await http
      .get(Uri.parse("https://api.dictionaryapi.dev/api/v2/entries/en/$word"));
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
  } else {
    log('Request failed with status: ${response.statusCode}.');
  }
  return Word.fromJson(response.body as Map<String, dynamic>);
}
