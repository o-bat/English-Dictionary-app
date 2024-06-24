import 'package:english_dictionary/components/provider.dart';
import 'package:english_dictionary/screens/details.dart';
import 'package:english_dictionary/services/local_save.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

TextEditingController controller = TextEditingController();

class _HomePageState extends State<HomePage> {
  Future<List<String>>? _futureData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: controller,
                onSubmitted: (value) {
                  context.read<PastDataProvider>().saveThePast(value);
                  controller.clear();
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                    builder: (context) => Details(
                      theWord: value,
                    ),
                  ))
                      .then((_) {
                    Provider.of<PastDataProvider>(context, listen: false)
                        .getPastData();
                  });
                },
                decoration: InputDecoration(
                  hintText: "Search",
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "History",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: FutureBuilder<List<String>>(
                    future: context.watch<PastDataProvider>().getPastData(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<String>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(child: Text("Error loading data"));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text("It looks empty here"));
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final word = snapshot.data!.reversed.toList();
                            return Card(
                              child: ListTile(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(
                                    MaterialPageRoute(
                                      builder: (context) => Details(
                                        theWord: word[index],
                                      ),
                                    ),
                                  )
                                      .then((_) {
                                    Provider.of<PastDataProvider>(context,
                                            listen: false)
                                        .getPastData();
                                  });
                                },
                                title: Text(word[index]),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
