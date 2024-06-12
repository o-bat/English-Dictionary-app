import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

CustomColors lightCustomColors = const CustomColors(danger: Color(0xFFE53935));
CustomColors darkCustomColors = const CustomColors(danger: Color(0xFFEF9A9A));
const _brandBlue = Color(0xFF1E88E5);
bool _isDemoUsingDynamicColors = false;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

int index = 0;

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
      ColorScheme lightColorScheme;
      ColorScheme darkColorScheme;

      if (lightDynamic != null && darkDynamic != null) {
        // On Android S+ devices, use the provided dynamic color scheme.
        // (Recommended) Harmonize the dynamic color scheme' built-in semantic colors.
        lightColorScheme = lightDynamic.harmonized();
        // (Optional) Customize the scheme as desired. For example, one might
        // want to use a brand color to override the dynamic [ColorScheme.secondary].
        lightColorScheme = lightColorScheme.copyWith(secondary: _brandBlue);
        // (Optional) If applicable, harmonize custom colors.
        lightCustomColors = lightCustomColors.harmonized(lightColorScheme);

        // Repeat for the dark color scheme.
        darkColorScheme = darkDynamic.harmonized();
        darkColorScheme = darkColorScheme.copyWith(secondary: _brandBlue);
        darkCustomColors = darkCustomColors.harmonized(darkColorScheme);

        _isDemoUsingDynamicColors = true; // ignore, only for demo purposes
      } else {
        // Otherwise, use fallback schemes.
        lightColorScheme = ColorScheme.fromSeed(
          seedColor: _brandBlue,
        );
        darkColorScheme = ColorScheme.fromSeed(
          seedColor: _brandBlue,
          brightness: Brightness.dark,
        );
      }
      return MaterialApp(
        theme: ThemeData(
          colorScheme: lightColorScheme,
          extensions: [lightCustomColors],
        ),
        darkTheme: ThemeData(
          colorScheme: darkColorScheme,
          extensions: [darkCustomColors],
        ),
        home: Scaffold(
            bottomNavigationBar: NavigationBar(
              selectedIndex: index,
              onDestinationSelected: (value) {
                setState(() {
                  index = value;
                });
              },
              destinations: const [
                NavigationDestination(
                    selectedIcon: Icon(Icons.home),
                    icon: Icon(Icons.home_outlined),
                    label: "Home"),
                NavigationDestination(
                    selectedIcon: Icon(Icons.bookmark),
                    icon: Icon(Icons.bookmark_border),
                    label: "Saved"),
                NavigationDestination(
                    selectedIcon: Icon(Icons.settings),
                    icon: Icon(Icons.settings_outlined),
                    label: "Settings"),
              ],
            ),
            body: SafeArea(
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
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: lightColorScheme.primaryFixed,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      );
    });
  }
}

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.danger,
  });

  final Color? danger;

  @override
  CustomColors copyWith({Color? danger}) {
    return CustomColors(
      danger: danger ?? this.danger,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      danger: Color.lerp(danger, other.danger, t),
    );
  }

  CustomColors harmonized(ColorScheme dynamic) {
    return copyWith(danger: danger!.harmonizeWith(dynamic.primary));
  }
}
