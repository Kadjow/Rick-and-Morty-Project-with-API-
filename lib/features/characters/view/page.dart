import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rmproject/features/characters/vm/view_model.dart';
import 'package:rmproject/theme/theme.dart';
import 'package:rmproject/theme/dark_theme.dart';
import '../model/character.dart';
import 'details_page.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});
  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  final _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeCtrl = context.watch<DarkTheme>();

    return Consumer<CharactersViewModel>(builder: (context, vm, _) {
      return Scaffold(
        appBar: AppBar(title: const Text('Rick and Morty')),
        drawer: Drawer(
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text('Opções', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 16),

                Text('Busca', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                TextField(
                  controller: _searchCtrl,
                  onChanged: vm.search,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: 'Buscar por nome...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.6),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: ValueListenableBuilder<TextEditingValue>(
                      valueListenable: _searchCtrl,
                      builder: (_, v, __) => v.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                _searchCtrl.clear();
                                vm.search('');
                                FocusScope.of(context).unfocus();
                              },
                            )
                          : const SizedBox.shrink(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Text('Filtro por status', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    _Chip(label: 'Todos',   selected: vm.status == null,       onSelected: (_) => vm.setStatus(null)),
                    _Chip(label: 'Alive',   selected: vm.status == 'alive',     onSelected: (_) => vm.setStatus('alive')),
                    _Chip(label: 'Dead',    selected: vm.status == 'dead',      onSelected: (_) => vm.setStatus('dead')),
                    _Chip(label: 'Unknown', selected: vm.status == 'unknown',   onSelected: (_) => vm.setStatus('unknown')),
                  ],
                ),
                const SizedBox(height: 20),

                Text('Aparência', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Dark Theme'),
                  value: themeCtrl.mode == ThemeMode.dark,
                  onChanged: themeCtrl.toggle,
                ),
              ],
            ),
          ),
        ),

        body: RefreshIndicator(
          onRefresh: vm.refresh,
          child: Builder(builder: (context) {
            if (vm.error != null && vm.items.isEmpty) {
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(24),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(vm.error!),
                          const SizedBox(height: 12),
                          OutlinedButton(onPressed: vm.onRetry, child: const Text('Tentar novamente')),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }

            if (vm.items.isEmpty && vm.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: vm.items.length + 1,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, i) {
                if (i < vm.items.length) {
                  final c = vm.items[i];
                  return _CharacterTile(
                    character: c,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => CharacterDetailsPage(character: c)),
                    ),
                  );
                }

                if (!vm.hasMore) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: Text('Fim da lista')),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: vm.loading ? null : vm.loadMore,
                      icon: vm.loading
                          ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                          : const Icon(Icons.expand_more),
                      label: Text(vm.loading ? 'Carregando...' : 'Carregar mais'),
                    ),
                  ),
                );
              },
            );
          }),
        ),
      );
    });
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, this.selected = false, required this.onSelected, super.key});
  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(label: Text(label), selected: selected, onSelected: onSelected);
  }
}

class _CharacterTile extends StatelessWidget {
  const _CharacterTile({required this.character, required this.onTap});
  final Character character;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppColors>()!;
    final s = character.status.toLowerCase();
    final statusColor = s == 'alive' ? palette.alive : s == 'dead' ? palette.dead : palette.unknown;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Hero(
              tag: 'char_${character.id}',
              child: Image.network(character.image, width: 96, height: 96, fit: BoxFit.cover),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      character.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${character.species} • ${character.status}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: statusColor),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
