import '../model/character.dart';
import 'api.dart';

class CharactersRepo {
  final CharactersApi api;
  CharactersRepo(this.api);

  Future<List<Character>> fetchFirstPage() async {
    final json = await api.getCharacters(page: 1);
    final results = json['results'] as List<dynamic>;
    return results
        .map((e) => Character.fromMap(e as Map<String, dynamic>))
        .toList();
  }
}
