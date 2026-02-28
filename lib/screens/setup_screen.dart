import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  @override
  void initState() {
    super.initState();
    final provider = context.read<TournamentProvider>();
    _nameController = TextEditingController(text: provider.structure.name);
    _levels = List.from(provider.structure.levels);
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
        actions: [
          TextButton(
            onPressed: _loadPreset,
            child: const Text('Load Preset', style: TextStyle(color: Colors.amber)),
          ),
        ],
      ),
      body: Column(
        children: [
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
          // Level list
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

  void _loadPreset() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A2A),
        title: const Text('Load Preset', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Load default tournament structure? Current changes will be lost.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _nameController.text = defaultStructure.name;
                _levels = List.from(defaultStructure.levels);
              });
              Navigator.pop(ctx);
            },
            child: const Text('Load', style: TextStyle(color: Colors.amber)),
          ),
        ],
      ),
    );
  }

  void _save() {
    final structure = TournamentStructure(
      name: _nameController.text.trim().isEmpty ? 'Tournament' : _nameController.text.trim(),
      levels: _levels,
    );
    context.read<TournamentProvider>().setStructure(structure);
    Navigator.pop(context);
  }
}
