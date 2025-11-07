import '../model/character.dart';
import 'api.dart';

class CharactersRepo {
  final CharactersApi api;
  CharactersRepo(this.api);

  Future<(List<Character>, bool)> fetch({
    required int page,
    String? name,
    String? status,
  }) async {
    final json = await api.getCharacters(page: page, name: name, status: status);
    final items = (json['results'] as List)
        .map((e) => Character.fromMap(e as Map<String, dynamic>))
        .toList();
        
    final hasMore = (json['info']?['next']) != null;
    return (items, hasMore);
  }
}
