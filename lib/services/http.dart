import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:english_dictionary/models/words.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

final player = AudioPlayer();

Future<List<Word>>? getTheWord(String word) async {
  var response = await http
      .get(Uri.parse("https://api.dictionaryapi.dev/api/v2/entries/en/$word"));
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
  } else {
    log('Request failed with status: ${response.statusCode}.');
  }
  var data = wordFromJson(response.body);
  return data;
}

String getPhonetics(AsyncSnapshot<List<Word>>? snapshot) {
  for (var i = 0; i < snapshot!.data![0].phonetics.length; i++) {
    if (snapshot.data![0].phonetics[i].text != null &&
        snapshot.data![0].phonetics[i].audio == "") {
      return snapshot.data![0].phonetics[i].text.toString();
    }
  }
  return snapshot.data![0].phonetics[0].text.toString();
}

Widget getAudios(AsyncSnapshot<List<Word>>? snapshot) {
  for (var i = 0; i < snapshot!.data![0].phonetics.length; i++) {
    if (snapshot.data![0].phonetics[i].audio != "") {
      return IconButton(
          onPressed: () async {
            await player.play(UrlSource(snapshot.data![0].phonetics[i].audio));
          },
          icon: const Icon(Icons.play_arrow));
    }
  }

  return Container();
}
