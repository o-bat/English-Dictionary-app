import 'package:audioplayers/audioplayers.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:english_dictionary/services/http.dart';
import 'package:flutter/material.dart';
import 'package:english_dictionary/models/words.dart';
import 'package:english_dictionary/services/local_save.dart';

class Details extends StatefulWidget {
  final String theWord;

  const Details({super.key, required this.theWord});

  @override
  State<Details> createState() => _DetailsState();
}

bool isPressed = false;
final player = AudioPlayer();

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return FutureBuilder(
            future: getTheWord(widget.theWord),
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
                              onPressed: () async {
                                if (await isItOnList(snapshot.data![0].word)) {
                                  setState(() {
                                    isPressed = true;
                                  });
                                  removeData(
                                      snapshot.data![0].word,
                                      snapshot.data![0].meanings[0]
                                          .definitions[0].definition);
                                } else {
                                  setState(() {
                                    isPressed = false;
                                  });
                                  saveTheWords(
                                      snapshot.data![0].word,
                                      snapshot.data![0].meanings[0]
                                          .definitions[0].definition);
                                }
                              },
                              icon: isPressed == true
                                  ? const Icon(Icons.bookmark_outline)
                                  : const Icon(Icons.bookmark))
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
