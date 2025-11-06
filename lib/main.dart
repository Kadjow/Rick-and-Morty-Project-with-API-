import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rmproject/features/characters/vm/view_model.dart';

import 'features/characters/data/api.dart';
import 'features/characters/data/repo.dart';
import 'features/characters/view/page.dart';

void main() {
  final api = CharactersApi();
  final repo = CharactersRepo(api);

  runApp(
    ChangeNotifierProvider(
      create: (_) => CharactersViewModel(repo)..loadFirstPage(),
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick and Morty',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00BFA6)),
      ),
      home: const CharactersPage(),
    );
  }
}
