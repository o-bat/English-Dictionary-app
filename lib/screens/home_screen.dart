import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Dictionary",
                    style: TextStyle(fontSize: 36),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: Platform.isAndroid == true
                          ? InputDecoration(
                              filled: true,
                              fillColor: lightDynamic?.secondary ??
                                  const Color(0x00000000),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(24),
                              ),
                            )
                          : InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(24),
                              ),
                            )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
