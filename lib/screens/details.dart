import 'package:audioplayers/audioplayers.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:english_dictionary/services/http.dart';
import 'package:flutter/material.dart';
import 'package:english_dictionary/models/words.dart';

class Details extends StatelessWidget {
  Details({super.key, required this.theWord});

  String theWord;
  final player = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return FutureBuilder(
            future: getTheWord(theWord),
            builder: (context, AsyncSnapshot<List<Word>>? snapshot) {
              if (snapshot!.hasData) {
                if (snapshot.data == null) {
                  return const Center(
                    child: Text("Error"),
                  );
                } else {
                  return Scaffold(
                      appBar: AppBar(
                        actions: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.bookmark_border))
                        ],
                        title: Text(snapshot.data![0].word),
                      ),
                      body: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(getPhonetics(snapshot)),
                                const Spacer(),
                                getAudios(snapshot)
                              ],
                            ),
                            Text(snapshot
                                .data![0].meanings[0].definitions[0].definition)
                          ],
                        ),
                      ));
                }
              } else {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            });
      },
    );
  }
}
