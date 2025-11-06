import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rmproject/features/characters/vm/view_model.dart';
import '../model/character.dart';
import 'details_page.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CharactersViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Rick and Morty')),
      body: RefreshIndicator(
        onRefresh: vm.refresh,
        child: Builder(
          builder: (_) {
            if (vm.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (vm.error != null) {
              return ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Center(child: Text(vm.error!)),
                  ),
                ],
              );
            }
            if (vm.items.isEmpty) {
              return ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: const Center(child: Text('Nenhum personagem.')),
                  ),
                ],
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: vm.items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (_, i) {
                final c = vm.items[i];
                return _CharacterTile(
                  character: c,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CharacterDetailsPage(character: c),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _CharacterTile extends StatelessWidget {
  final Character character;
  final VoidCallback onTap;
  const _CharacterTile({required this.character, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(12);
    return InkWell(
      onTap: onTap,
      borderRadius: radius,
      child: Ink(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: radius,
          boxShadow: kElevationToShadow[1],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.network(
                character.image,
                width: 96,
                height: 96,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      character.name,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${character.species} • ${character.status}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}
