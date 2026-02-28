import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/blind_level.dart';
import '../providers/tournament_provider.dart';

class BlindInfoDisplay extends StatelessWidget {
  const BlindInfoDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TournamentProvider>();
    final screenWidth = MediaQuery.of(context).size.width;
    final infoFontSize = (screenWidth * 0.04).clamp(16.0, 48.0);
    final nextFontSize = (screenWidth * 0.025).clamp(12.0, 28.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Current blind info
        if (provider.isBlind) _buildBlindRow(provider.currentLevel as BlindLevel, infoFontSize),
        if (provider.isBreak)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.coffee, color: Colors.amber, size: infoFontSize),
                const SizedBox(width: 12),
                Text(
                  'BREAK TIME',
                  style: TextStyle(
                    fontSize: infoFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
          ),

        const SizedBox(height: 16),

        // Divider
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.15),
          child: const Divider(color: Colors.white24, height: 1),
        ),

        const SizedBox(height: 12),

        // Next level preview
        if (provider.nextBlindLevel != null)
          _buildNextInfo(provider.nextBlindLevel!, nextFontSize, provider.isBreak),
        if (provider.isLastLevel && provider.nextBlindLevel == null)
          Text(
            'FINAL LEVEL',
            style: TextStyle(
              fontSize: nextFontSize,
              color: Colors.white38,
              letterSpacing: 2,
            ),
          ),
      ],
    );
  }

  Widget _buildBlindRow(BlindLevel level, double fontSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildChip('SB', _formatNumber(level.smallBlind), fontSize, Colors.blue),
        const SizedBox(width: 20),
        _buildChip('BB', _formatNumber(level.bigBlind), fontSize, Colors.green),
        if (level.ante > 0) ...[
          const SizedBox(width: 20),
          _buildChip('ANTE', _formatNumber(level.ante), fontSize, Colors.orange),
        ],
      ],
    );
  }

  Widget _buildChip(String label, String value, double fontSize, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: fontSize * 0.4,
            color: color.withValues(alpha: 0.7),
            fontWeight: FontWeight.w500,
            letterSpacing: 2,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildNextInfo(BlindLevel next, double fontSize, bool currentIsBreak) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          currentIsBreak ? 'NEXT:  ' : 'NEXT:  ',
          style: TextStyle(fontSize: fontSize, color: Colors.white38),
        ),
        Text(
          'SB ${_formatNumber(next.smallBlind)}  /  BB ${_formatNumber(next.bigBlind)}',
          style: TextStyle(
            fontSize: fontSize,
            color: Colors.white60,
            fontWeight: FontWeight.w500,
          ),
        ),
        if (next.ante > 0)
          Text(
            '  /  Ante ${_formatNumber(next.ante)}',
            style: TextStyle(
              fontSize: fontSize,
              color: Colors.white60,
              fontWeight: FontWeight.w500,
            ),
          ),
      ],
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(number % 1000 == 0 ? 0 : 1)}K';
    }
    return number.toString();
  }
}
