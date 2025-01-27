import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:tp6/AppBar/appbar.dart';
import 'package:tp6/album.dart';
import 'iconenavbar_icons.dart';

class ThemeController extends ValueNotifier<ThemeMode> {
  ThemeController() : super(ThemeMode.light);

  void toggleTheme() {
    value = value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeStr = await rootBundle.loadString('assets/lighttheme.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;

  final themeStrDark = await rootBundle.loadString('assets/darktheme.json');
  final themeJsonDark = jsonDecode(themeStrDark);
  final themeDark = ThemeDecoder.decodeThemeData(themeJsonDark)!;

  runApp(MyApp(themelight: theme, themeNight: themeDark));
}

class MyApp extends StatelessWidget {
  final ThemeData themelight;
  final ThemeData themeNight;
  final ThemeController themeController = ThemeController();

  MyApp({Key? key, required this.themelight, required this.themeNight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeController,
      builder: (context, themeMode, _) {
        return MaterialApp(
          title: 'Gestion des albums',
          debugShowCheckedModeBanner: false,
          theme: themelight,
          darkTheme: themeNight,
          themeMode: themeMode,
          home: MyHomePage(title: "Page d'Accueil", themeController: themeController),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final ThemeController themeController;

  const MyHomePage({Key? key, required this.title, required this.themeController})
      : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar_Principal(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.lightbulb),
            onPressed: widget.themeController.toggleTheme,
          ),
        ],
      ),
      body: IndexedStack(
        index: currentPageIndex,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                "Page album",
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Album(),
            ],
          ),
          Column(
          children: const <Widget>[
            Text('Settings'),
            ]
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Iconenavbar.home),
            label: 'Accueil',
          ),
          NavigationDestination(
            icon: Icon(Iconenavbar.music_note),
            label: 'Page Suivante',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark),
            icon: Icon(Iconenavbar.settings),
            label: 'Paramètres',
          ),
        ],
      ),
    );
  }
}
