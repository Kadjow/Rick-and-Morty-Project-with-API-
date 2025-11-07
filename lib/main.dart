import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/characters/data/api.dart';
import 'features/characters/data/repo.dart';
import 'features/characters/vm/view_model.dart';
import 'theme/dark_theme.dart';
import 'theme/theme.dart';
import 'splash/splash_screen.dart';

void main() {
  final api = CharactersApi();
  final repo = CharactersRepo(api);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DarkTheme()),
        ChangeNotifierProvider(create: (_) => CharactersViewModel(repo)..loadFirstPage()),
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<DarkTheme>().mode;
    return MaterialApp(
      title: 'Rick and Morty',
      debugShowCheckedModeBanner: false,
      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
      themeMode: mode,
      home: const SplashScreen(),
    );
  }
}
