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
  void initState() {
    super.initState();
    checkIsPressed();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Future<void> checkIsPressed() async {
    bool onList = await isItOnList(widget.theWord);
    setState(() {
      isPressed = onList;
    });
  }

  Future<void> toggleBookmark(Word word) async {
    if (isPressed) {
      await removeData(word.word, word.meanings[0].definitions[0].definition);
    } else {
      await saveTheWords(word.word, word.meanings[0].definitions[0].definition);
    }
    setState(() {
      isPressed = !isPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getTheWord(widget.theWord),
        builder: (context, AsyncSnapshot<List<Word>>? snapshot) {
          if (snapshot!.hasError) {
            if (snapshot.hasError) {
              return Scaffold(
                body: SafeArea(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Word not Found (Looks lika a 404)"),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Go Back"))
                      ],
                    ),
                  ),
                ),
              );
            }
          }
          if (snapshot.hasData) {
            return Scaffold(
                appBar: AppBar(
                  actions: [
                    IconButton(
                      onPressed: () => toggleBookmark(snapshot.data![0]),
                      icon: Icon(
                          isPressed ? Icons.bookmark : Icons.bookmark_outline),
                    ),
                  ],
                  title: Text(snapshot.data![0].word),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            getPhonetics(snapshot),
                            style: const TextStyle(fontFamily: ""),
                          ),
                          const Spacer(),
                          getAudios(snapshot)
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data![0].meanings.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                title: Text(snapshot
                                    .data![0].meanings[index].partOfSpeech),
                                subtitle: Text(snapshot.data![0].meanings[index]
                                    .definitions[0].definition),
                              ),
                            );
                          },
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: const Text("synonyms"),
                          subtitle: Text(
                              snapshot.data![0].meanings[0].synonyms.isEmpty
                                  ? "Not Found"
                                  : snapshot.data![0].meanings[0].synonyms
                                      .toString()
                                      .replaceAll("[", "")
                                      .replaceAll("]", " ")),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: const Text("antonyms"),
                          subtitle: Text(
                              snapshot.data![0].meanings[0].antonyms.isEmpty
                                  ? "Not Found"
                                  : snapshot.data![0].meanings[0].antonyms
                                      .toString()
                                      .replaceAll("[", "")
                                      .replaceAll("]", " ")),
                        ),
                      ),
                    ],
                  ),
                ));
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
