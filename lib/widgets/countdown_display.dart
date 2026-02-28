import 'package:flutter/material.dart';
import '../providers/tournament_provider.dart';
import 'package:provider/provider.dart';

class CountdownDisplay extends StatelessWidget {
  const CountdownDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TournamentProvider>();
    final screenWidth = MediaQuery.of(context).size.width;
    final timerFontSize = (screenWidth * 0.15).clamp(48.0, 180.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Level indicator
        Text(
          provider.isBreak ? 'BREAK' : 'LEVEL ${provider.displayLevelNumber}',
          style: TextStyle(
            fontSize: (screenWidth * 0.04).clamp(18.0, 48.0),
            fontWeight: FontWeight.w300,
            color: Colors.white70,
            letterSpacing: 4,
          ),
        ),
        const SizedBox(height: 8),
        // Big countdown timer
        Text(
          provider.formattedTime,
          style: TextStyle(
            fontSize: timerFontSize,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
            color: _getTimerColor(provider),
            shadows: [
              Shadow(
                color: _getTimerColor(provider).withValues(alpha: 0.5),
                blurRadius: 20,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Progress bar
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: provider.progress,
              minHeight: 6,
              backgroundColor: Colors.white12,
              valueColor: AlwaysStoppedAnimation<Color>(
                provider.isBreak ? Colors.amber : Colors.green,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Color _getTimerColor(TournamentProvider provider) {
    if (provider.isBreak) return Colors.amber;
    if (provider.remainingSeconds <= 10) return Colors.red;
    if (provider.remainingSeconds <= 60) return Colors.orange;
    return Colors.white;
  }
}
