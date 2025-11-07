import 'package:flutter/material.dart';
import 'package:rmproject/theme/theme.dart';
import '../model/character.dart';

class CharacterDetailsPage extends StatelessWidget {
  const CharacterDetailsPage({super.key, required this.character});
  final Character character;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppColors>()!;
    final statusColor = switch (character.status.toLowerCase()) {
      'alive' => palette.alive,
      'dead'  => palette.dead,
      _       => palette.unknown,
    };

    return Scaffold(
      appBar: AppBar(title: Text(character.name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Hero(
              tag: 'char_${character.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  character.image,
                  width: 240,
                  height: 240,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          _Info(label: 'Name',    value: character.name),
          _Info(label: 'Status',  value: character.status, valueColor: statusColor),
          _Info(label: 'Species', value: character.species),
        ],
      ),
    );
  }
}

class _Info extends StatelessWidget {
  const _Info({required this.label, required this.value, this.valueColor});
  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final labelStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: cs.primary,
          fontWeight: FontWeight.w600,
        );
    final valueStyle = Theme.of(context).textTheme.titleMedium?.copyWith(color: valueColor);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 96, child: Text(label, style: labelStyle)),
          const SizedBox(width: 8),
          Expanded(child: Text(value, style: valueStyle)),
        ],
      ),
    );
  }
}
