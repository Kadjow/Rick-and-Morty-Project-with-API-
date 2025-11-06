import 'package:flutter/foundation.dart';
import '../model/character.dart';
import '../data/repo.dart';

class CharactersViewModel extends ChangeNotifier {
  final CharactersRepo repo;
  CharactersViewModel(this.repo);

  List<Character> _items = [];
  List<Character> get items => _items;

  bool _loading = false;
  bool get loading => _loading;

  String? _error;
  String? get error => _error;

  Future<void> loadFirstPage() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _items = await repo.fetchFirstPage();
    } catch (_) {
      _error = 'Falha ao carregar personagens.';
    }

    _loading = false;
    notifyListeners();
  }

  Future<void> refresh() async => loadFirstPage();
}
