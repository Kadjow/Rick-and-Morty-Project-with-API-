import 'dart:convert';
import 'package:http/http.dart' as http;

class CharactersApi {
  static const _base = 'https://rickandmortyapi.com/api';

  Future<Map<String, dynamic>> getCharacters({int page = 1}) async {
    final res = await http.get(Uri.parse('$_base/character?page=$page'));
    if (res.statusCode == 200) {
      return jsonDecode(res.body) as Map<String, dynamic>;
    }
    throw Exception('Erro HTTP ${res.statusCode}');
  }
}
