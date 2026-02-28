import '../models/blind_level.dart';
import '../models/break_level.dart';
import '../models/tournament_structure.dart';

final defaultStructure = TournamentStructure(
  name: 'Default Tournament',
  levels: [
    const BlindLevel(level: 1, smallBlind: 25, bigBlind: 50, ante: 0, durationMinutes: 15),
    const BlindLevel(level: 2, smallBlind: 50, bigBlind: 100, ante: 0, durationMinutes: 15),
    const BlindLevel(level: 3, smallBlind: 75, bigBlind: 150, ante: 0, durationMinutes: 15),
    const BlindLevel(level: 4, smallBlind: 100, bigBlind: 200, ante: 25, durationMinutes: 15),
    const BreakLevel(durationMinutes: 10),
    const BlindLevel(level: 5, smallBlind: 150, bigBlind: 300, ante: 50, durationMinutes: 15),
    const BlindLevel(level: 6, smallBlind: 200, bigBlind: 400, ante: 50, durationMinutes: 15),
    const BlindLevel(level: 7, smallBlind: 300, bigBlind: 600, ante: 75, durationMinutes: 15),
    const BlindLevel(level: 8, smallBlind: 400, bigBlind: 800, ante: 100, durationMinutes: 15),
    const BreakLevel(durationMinutes: 10),
    const BlindLevel(level: 9, smallBlind: 500, bigBlind: 1000, ante: 100, durationMinutes: 15),
    const BlindLevel(level: 10, smallBlind: 600, bigBlind: 1200, ante: 200, durationMinutes: 15),
    const BlindLevel(level: 11, smallBlind: 800, bigBlind: 1600, ante: 200, durationMinutes: 15),
    const BlindLevel(level: 12, smallBlind: 1000, bigBlind: 2000, ante: 300, durationMinutes: 15),
  ],
);
