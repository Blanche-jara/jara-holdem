import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/blind_level.dart';
import '../models/tournament_structure.dart';
import '../presets/default_presets.dart';
import '../providers/tournament_provider.dart';
import '../widgets/level_list_editor.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  late TextEditingController _nameController;
  late List<dynamic> _levels;
  late bool _isCashGame;

  @override
  void initState() {
    super.initState();
    final provider = context.read<TournamentProvider>();
    _nameController = TextEditingController(text: provider.structure.name);
    _levels = List.from(provider.structure.levels);
    _isCashGame = provider.structure.isCashGame;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text('Tournament Setup', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Preset selector
          _buildPresetSelector(),
          const Divider(color: Colors.white12, height: 1),
          // Tournament name
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _nameController,
              style: const TextStyle(color: Colors.white, fontSize: 18),
              decoration: const InputDecoration(
                labelText: 'Tournament Name',
                labelStyle: TextStyle(color: Colors.white54),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white24),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
            ),
          ),
          // Cash game: SB/BB editor only
          if (_isCashGame) _buildCashGameEditor(),
          // Tournament: full level editor
          if (!_isCashGame)
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 80),
                child: LevelListEditor(
                  levels: _levels,
                  onChanged: (newLevels) {
                    setState(() {
                      _levels = newLevels;
                    });
                  },
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: Container(
        color: const Color(0xFF1E1E1E),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white54,
                  side: const BorderSide(color: Colors.white24),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Cancel'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Save & Start', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPresetSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const Text('Preset:', style: TextStyle(color: Colors.white54, fontSize: 14)),
          const SizedBox(width: 12),
          _PresetChip(
            label: 'Classic Tournament',
            selected: !_isCashGame && _nameController.text == classicTournament.name,
            onTap: () => _applyPreset(classicTournament),
          ),
          const SizedBox(width: 8),
          _PresetChip(
            label: 'Classic Cash',
            selected: _isCashGame,
            onTap: () => _applyPreset(classicCash),
          ),
          const SizedBox(width: 8),
          _PresetChip(
            label: 'Empty Slate',
            selected: !_isCashGame && _levels.isEmpty,
            onTap: () => _applyPreset(emptySlate),
          ),
        ],
      ),
    );
  }

  void _applyPreset(TournamentStructure preset) {
    setState(() {
      _nameController.text = preset.name;
      _levels = List.from(preset.levels);
      _isCashGame = preset.isCashGame;
    });
  }

  Widget _buildCashGameEditor() {
    final blind = _levels.isNotEmpty ? _levels[0] as BlindLevel : const BlindLevel(level: 0, smallBlind: 100, bigBlind: 200, durationMinutes: 0);
    final sbController = TextEditingController(text: blind.smallBlind.toString());
    final bbController = TextEditingController(text: blind.bigBlind.toString());

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.casino, color: Colors.cyan, size: 48),
            const SizedBox(height: 16),
            const Text(
              'Cash Game Mode',
              style: TextStyle(color: Colors.cyan, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'Single level with no time limit',
              style: TextStyle(color: Colors.white38, fontSize: 14),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: sbController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      labelText: 'Small Blind',
                      labelStyle: TextStyle(color: Colors.white54),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.cyan)),
                    ),
                    onChanged: (val) {
                      final sb = int.tryParse(val) ?? blind.smallBlind;
                      setState(() {
                        _levels = [blind.copyWith(smallBlind: sb, durationMinutes: 0)];
                      });
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('/', style: TextStyle(color: Colors.white38, fontSize: 28)),
                ),
                Expanded(
                  child: TextField(
                    controller: bbController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      labelText: 'Big Blind',
                      labelStyle: TextStyle(color: Colors.white54),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.cyan)),
                    ),
                    onChanged: (val) {
                      final bb = int.tryParse(val) ?? blind.bigBlind;
                      setState(() {
                        _levels = [blind.copyWith(bigBlind: bb, durationMinutes: 0)];
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _save() {
    final structure = TournamentStructure(
      name: _nameController.text.trim().isEmpty ? 'Tournament' : _nameController.text.trim(),
      levels: _levels,
      isCashGame: _isCashGame,
    );
    context.read<TournamentProvider>().setStructure(structure);
    Navigator.pop(context);
  }
}

class _PresetChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _PresetChip({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: selected ? Colors.green.shade800 : Colors.transparent,
          border: Border.all(color: selected ? Colors.green : Colors.white24),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.white54,
            fontSize: 13,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
