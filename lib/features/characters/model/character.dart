class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String image;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.image,
  });

  factory Character.fromMap(Map<String, dynamic> m) => Character(
        id: m['id'] as int,
        name: m['name'] as String? ?? '',
        status: m['status'] as String? ?? 'unknown',
        species: m['species'] as String? ?? 'unknown',
        image: m['image'] as String? ?? '',
      );
}
