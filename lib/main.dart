import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:tp6/AppBar/appbar.dart';
import 'package:tp6/album.dart';
import 'Theme/ThemeController.dart';
import 'iconenavbar_icons.dart';

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
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                color: Colors.green,
                child: Row(
                  children: [
                    Image.asset('images/imgAccueil/vinyltransp.webp'),
                    Expanded(
                      child: Text(
                        "Bienvenue sur l'application de gestion d'album",
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,


                  children: <Widget>[
                    ListTile(
                      title: Text("News"),
                      subtitle: Text("Dernières actualités"),
                    )
                  ],
                ),
              ),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text("Version 1 en cours de développement"),
                      subtitle: Text("Wait and see"),
                    )
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: const <Widget>[
              Text('Musique'),
            ],
          ),
          Column(
            children: const <Widget>[
              Text('Settings'),
            ],
          ),
        ],
      ),

      floatingActionButton: currentPageIndex == 0
          ? FloatingActionButton(
        onPressed: () {
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add),

      ): null,

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
