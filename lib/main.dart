import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/tournament_provider.dart';
import 'screens/timer_screen.dart';

void main() {
  runApp(const JaraHoldemApp());
}

class JaraHoldemApp extends StatelessWidget {
  const JaraHoldemApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TournamentProvider()..initialize(),
      child: MaterialApp(
        title: 'Jara Holdem Timer',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color(0xFF0A1A0A),
        ),
        home: const TimerScreen(),
      ),
    );
  }
}
