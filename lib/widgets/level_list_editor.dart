import 'package:flutter/material.dart';
import '../models/blind_level.dart';
import '../models/break_level.dart';

class LevelListEditor extends StatelessWidget {
  final List<dynamic> levels;
  final ValueChanged<List<dynamic>> onChanged;

  const LevelListEditor({
    super.key,
    required this.levels,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Level list
        ...List.generate(levels.length, (index) {
          final level = levels[index];
          if (level is BlindLevel) {
            return _BlindLevelTile(
              level: level,
              index: index,
              onEdit: () => _editBlindLevel(context, index, level),
              onDelete: () => _deleteLevel(index),
            );
          } else if (level is BreakLevel) {
            return _BreakLevelTile(
              level: level,
              index: index,
              onEdit: () => _editBreakLevel(context, index, level),
              onDelete: () => _deleteLevel(index),
            );
          }
          return const SizedBox.shrink();
        }),
        const SizedBox(height: 16),
        // Add buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () => _addBlindLevel(context),
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add Level'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade800,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton.icon(
              onPressed: _addBreak,
              icon: const Icon(Icons.coffee, size: 18),
              label: const Text('Add Break'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber.shade800,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _deleteLevel(int index) {
    final newLevels = List<dynamic>.from(levels);
    newLevels.removeAt(index);
    // Renumber blind levels
    onChanged(_renumberLevels(newLevels));
  }

  void _addBreak() {
    final newLevels = List<dynamic>.from(levels);
    newLevels.add(const BreakLevel(durationMinutes: 10));
    onChanged(newLevels);
  }

  void _addBlindLevel(BuildContext context) {
    // Auto-calculate next level values based on last blind level
    BlindLevel lastBlind = const BlindLevel(level: 0, smallBlind: 0, bigBlind: 0);
    for (final l in levels.reversed) {
      if (l is BlindLevel) {
        lastBlind = l;
        break;
      }
    }

    final nextLevel = BlindLevel(
      level: _countBlinds() + 1,
      smallBlind: lastBlind.smallBlind > 0 ? (lastBlind.smallBlind * 1.5).round() : 25,
      bigBlind: lastBlind.bigBlind > 0 ? (lastBlind.bigBlind * 1.5).round() : 50,
      ante: lastBlind.ante > 0 ? (lastBlind.ante * 1.5).round() : 0,
      durationMinutes: lastBlind.durationMinutes > 0 ? lastBlind.durationMinutes : 15,
    );

    _editBlindLevel(context, -1, nextLevel);
  }

  int _countBlinds() {
    return levels.whereType<BlindLevel>().length;
  }

  void _editBlindLevel(BuildContext context, int index, BlindLevel level) {
    final sbController = TextEditingController(text: level.smallBlind.toString());
    final bbController = TextEditingController(text: level.bigBlind.toString());
    final anteController = TextEditingController(text: level.ante.toString());
    final durationController = TextEditingController(text: level.durationMinutes.toString());

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A2A),
        title: Text(
          index == -1 ? 'Add Blind Level' : 'Edit Level ${level.level}',
          style: const TextStyle(color: Colors.white),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildField('Small Blind', sbController),
              _buildField('Big Blind', bbController),
              _buildField('Ante', anteController),
              _buildField('Duration (min)', durationController),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final newLevel = BlindLevel(
                level: level.level,
                smallBlind: int.tryParse(sbController.text) ?? level.smallBlind,
                bigBlind: int.tryParse(bbController.text) ?? level.bigBlind,
                ante: int.tryParse(anteController.text) ?? 0,
                durationMinutes: int.tryParse(durationController.text) ?? 15,
              );
              final newLevels = List<dynamic>.from(levels);
              if (index == -1) {
                newLevels.add(newLevel);
              } else {
                newLevels[index] = newLevel;
              }
              onChanged(_renumberLevels(newLevels));
              Navigator.pop(ctx);
            },
            child: const Text('Save', style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }

  void _editBreakLevel(BuildContext context, int index, BreakLevel level) {
    final durationController = TextEditingController(text: level.durationMinutes.toString());

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A2A),
        title: const Text('Edit Break', style: TextStyle(color: Colors.white)),
        content: _buildField('Duration (min)', durationController),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final newLevel = BreakLevel(
                durationMinutes: int.tryParse(durationController.text) ?? 10,
                colorUp: level.colorUp,
              );
              final newLevels = List<dynamic>.from(levels);
              newLevels[index] = newLevel;
              onChanged(newLevels);
              Navigator.pop(ctx);
            },
            child: const Text('Save', style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white54),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white24),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          ),
        ),
      ),
    );
  }

  List<dynamic> _renumberLevels(List<dynamic> levels) {
    int blindNum = 1;
    return levels.map((l) {
      if (l is BlindLevel) {
        final renumbered = l.copyWith(level: blindNum);
        blindNum++;
        return renumbered;
      }
      return l;
    }).toList();
  }
}

class _BlindLevelTile extends StatelessWidget {
  final BlindLevel level;
  final int index;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _BlindLevelTile({
    required this.level,
    required this.index,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1E1E1E),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green.shade800,
          radius: 16,
          child: Text(
            '${level.level}',
            style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          'SB ${level.smallBlind}  /  BB ${level.bigBlind}${level.ante > 0 ? '  /  Ante ${level.ante}' : ''}',
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
        subtitle: Text(
          '${level.durationMinutes} min',
          style: const TextStyle(color: Colors.white38, fontSize: 12),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, size: 18, color: Colors.white38),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete, size: 18, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
        dense: true,
      ),
    );
  }
}

class _BreakLevelTile extends StatelessWidget {
  final BreakLevel level;
  final int index;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _BreakLevelTile({
    required this.level,
    required this.index,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber.shade900.withValues(alpha: 0.3),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.amber,
          radius: 16,
          child: Icon(Icons.coffee, size: 16, color: Colors.black),
        ),
        title: Text(
          'BREAK — ${level.durationMinutes} min',
          style: const TextStyle(color: Colors.amber, fontSize: 14, fontWeight: FontWeight.w500),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, size: 18, color: Colors.white38),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete, size: 18, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
        dense: true,
      ),
    );
  }
}
