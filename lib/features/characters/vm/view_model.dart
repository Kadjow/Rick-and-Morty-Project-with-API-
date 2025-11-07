import 'dart:async';
import 'dart:io'; 
import 'package:flutter/foundation.dart';
import '../model/character.dart';
import '../data/repo.dart';

class CharactersViewModel extends ChangeNotifier {
  final CharactersRepo repo;
  CharactersViewModel(this.repo);

  final List<Character> _items = [];
  List<Character> get items => List.unmodifiable(_items);

  bool _loading = false; bool get loading => _loading;
  String? _error; String? get error => _error;
  bool _hasMore = true; bool get hasMore => _hasMore;

  int _page = 1;
  String? _query;
  String? _status;
  String? get status => _status;

  void setStatus(String? status) {
    _status = status;
    loadFirstPage();
  }

  Timer? _debounce;

  Future<void> loadFirstPage() async {
    _page = 1;
    _hasMore = true;
    _items.clear();
    await _load();
  }

  Future<void> loadMore() async {
    if (_loading || !_hasMore) return;
    await _load();
  }

  Future<void> refresh() async => loadFirstPage();

  Future<void> _load() async {
    _loading = true; _error = null; notifyListeners();
    try {
      final (data, hasMore) = await repo.fetch(page: _page, name: _query, status: _status);
      _items.addAll(data);
      _hasMore = hasMore;
      if (_hasMore) _page++;
    } on SocketException {
      _error = 'Sem conexão com a internet.';
    } on TimeoutException {
      _error = 'Tempo de conexão esgotado.';
    } catch (_) {
      _error = 'Falha ao carregar personagens.';
    }
    _loading = false; notifyListeners();
  }

  void onRetry() => loadFirstPage();

  void search(String q) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      final newQuery = q.trim().isEmpty ? null : q.trim();
      if (newQuery == _query) return;
      _query = newQuery;
      loadFirstPage();
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
