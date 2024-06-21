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
  Future<List<Map<dynamic, dynamic>>>? _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = getData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      _futureData = getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
      return Scaffold(
        body: FutureBuilder<List<Map<dynamic, dynamic>>>(
          future: _futureData,
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
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: (context) => Details(
                                    theWord: word["id"],
                                  )))
                          .then((_) {
                        // Refresh the state when returning from the Details page
                        setState(() {
                          _futureData = getData();
                        });
                      });
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
