/*import 'dart:developer';

import 'package:english_dictionary/services/local_save.dart';
import 'package:flutter/material.dart';

class Saved extends StatefulWidget {
  const Saved({super.key});

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: getData(),
            builder:
                (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width / 2,
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Text(snapshot.data![index]["id"]),
                          Text(snapshot.data![index]["def"]),
                        ],
                      );
                    },
                  ),
                );
              }
              if (snapshot.hasError) {
                return const Center(child: Text("Looks like a 404"));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }
            )
            );
  }
}*/

import 'package:dynamic_color/dynamic_color.dart';
import 'package:english_dictionary/screens/details.dart';
import 'package:english_dictionary/services/local_save.dart';
import 'package:flutter/material.dart';

class Saved extends StatefulWidget {
  const Saved({super.key});

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
      return Scaffold(
        body: FutureBuilder<List<Map<dynamic, dynamic>>>(
          future: getData(),
          builder: (BuildContext context,
              AsyncSnapshot<List<Map<dynamic, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text("Error loading data"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No saved words found"));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final word = snapshot.data![index];
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Details(
                                theWord: word["id"],
                              )));
                    },
                    title: Text(word["id"]!),
                    subtitle: Text(word["def"]!),
                  );
                },
              );
            }
          },
        ),
      );
    });
  }
}
