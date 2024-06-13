import 'package:dynamic_color/dynamic_color.dart';
import 'package:english_dictionary/services/http.dart';
import 'package:flutter/material.dart';
import 'package:english_dictionary/models/words.dart';

class Details extends StatelessWidget {
  Details({super.key, required this.theWord});

  String theWord;

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return FutureBuilder(
            future: getTheWord(theWord),
            builder: (context, AsyncSnapshot<Word> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == null) {
                  return const Center(
                    child: Text("Error"),
                  );
                } else {
                  return Container();
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            });
      },
    );
  }
}
