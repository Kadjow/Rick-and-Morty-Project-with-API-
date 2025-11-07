import 'dart:convert';
import 'package:http/http.dart' as http;

class CharactersApi {
  static const _base = 'https://rickandmortyapi.com/api';

  Future<Map<String, dynamic>> getCharacters({
    int page = 1,
    String? name,
    String? status,
  }) async {
    final params = <String, String>{'page': '$page'};
    if (name != null && name.trim().isNotEmpty) params['name'] = name.trim();
    if (status != null && status.isNotEmpty) params['status'] = status;

    final uri = Uri.parse('$_base/character').replace(queryParameters: params);
    final res = await http.get(uri).timeout(const Duration(seconds: 15)); 
    if (res.statusCode == 200) {
      return jsonDecode(res.body) as Map<String, dynamic>;
    }
    throw Exception('Erro HTTP ${res.statusCode}');
  }
}
