import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// --- Card Widget ---
class _PokerCard extends StatelessWidget {
  final String rank;
  final String suit; // ♠ ♥ ♦ ♣
  final double width;
  final double height;

  const _PokerCard(this.rank, this.suit, {this.width = 38, this.height = 54});

  bool get _isRed => suit == '♥' || suit == '♦';

  @override
  Widget build(BuildContext context) {
    final color = _isRed ? Colors.red.shade600 : Colors.grey.shade900;
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 3, offset: const Offset(1, 1))],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(rank, style: TextStyle(color: color, fontSize: width * 0.38, fontWeight: FontWeight.w900, height: 1)),
          Text(suit, style: TextStyle(color: color, fontSize: width * 0.32, height: 1)),
        ],
      ),
    );
  }
}

class _CardRow extends StatelessWidget {
  final List<List<String>> cards; // [['A', '♠'], ['K', '♠']]
  final double cardWidth;
  final double cardHeight;

  const _CardRow(this.cards, {this.cardWidth = 38, this.cardHeight = 54});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: cards.map((c) => _PokerCard(c[0], c[1], width: cardWidth, height: cardHeight)).toList(),
    );
  }
}

// --- Help Screen ---
class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1A1A1A),
          title: Text(
            'HOLDEM GUIDE',
            style: GoogleFonts.orbitron(
              color: Colors.amber.shade300,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.red.shade400,
            indicatorWeight: 3,
            labelColor: Colors.red.shade400,
            unselectedLabelColor: Colors.white38,
            labelStyle: GoogleFonts.orbitron(fontSize: 12, fontWeight: FontWeight.w700),
            unselectedLabelStyle: GoogleFonts.orbitron(fontSize: 12, fontWeight: FontWeight.w400),
            tabAlignment: TabAlignment.start,
            tabs: const [
              Tab(text: 'BASICS'),
              Tab(text: 'ACTIONS'),
              Tab(text: 'STREETS'),
              Tab(text: 'HANDS'),
              Tab(text: 'POSITIONS'),
              Tab(text: 'RANKINGS'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildBasicsPage(context),
            _buildActionsPage(context),
            _buildStreetsPage(context),
            _buildHandsPage(context),
            _buildPositionsPage(context),
            _buildRankingsPage(context),
          ],
        ),
      ),
    );
  }

  // ===== BASICS =====
  Widget _buildBasicsPage(BuildContext context) {
    return _pageList(context, '기본 용어', [
      _row('SB', 'Small Blind. 딜러 왼쪽 첫 번째 플레이어가 강제로 베팅하는 금액. BB의 절반이 일반적.'),
      _row('BB', 'Big Blind. 딜러 왼쪽 두 번째 플레이어가 강제로 베팅하는 금액. 해당 레벨의 최소 베팅 단위.'),
      _row('Ante', '모든 플레이어가 매 핸드 시작 전 내는 강제 베팅. 액션을 유도하기 위해 중후반부터 적용.'),
      _row('Dealer', '딜러 버튼(D)을 가진 포지션. 매 핸드마다 시계 방향으로 이동하며, 베팅 순서의 기준이 된다.'),
      _row('Level', '블라인드 단계. 일정 시간이 지나면 다음 레벨로 올라가며 SB/BB/Ante가 증가한다.'),
      _row('Break', '휴식 시간. 몇 레벨마다 주어지며, 이 시간 동안 게임이 중단된다.'),
      _row('Pot', '현재 핸드에서 모든 플레이어가 베팅한 칩의 총합.'),
    ]);
  }

  // ===== ACTIONS =====
  Widget _buildActionsPage(BuildContext context) {
    return _pageList(context, '액션', [
      _row('Fold', '패를 포기하고 해당 핸드에서 빠지는 것. 이미 베팅한 칩은 돌려받을 수 없다.'),
      _row('Check', '베팅 없이 차례를 넘기는 것. 앞에 베팅이 없을 때만 가능.'),
      _row('Call', '이전 플레이어의 베팅 금액과 동일하게 따라 베팅하는 것.'),
      _row('Bet', '해당 라운드에서 첫 번째로 칩을 거는 것. 이후 다른 플레이어가 콜/레이즈/폴드를 선택.'),
      _row('Raise', '이전 베팅보다 더 높은 금액으로 베팅. 최소 레이즈는 직전 레이즈 폭 이상.'),
      _row('Re-raise', '레이즈에 대해 다시 레이즈하는 것. 3-Bet, 4-Bet 등으로도 불린다.'),
      _row('All-in', '보유한 칩 전부를 베팅. 올인 후에는 추가 베팅 없이 쇼다운까지 진행.'),
    ]);
  }

  // ===== STREETS =====
  Widget _buildStreetsPage(BuildContext context) {
    return _pageList(context, '게임 진행 단계', [
      _row('Preflop', '커뮤니티 카드가 깔리기 전 단계. 각 플레이어는 2장의 홀카드를 받고 첫 베팅을 진행.'),
      _row('Flop', '커뮤니티 카드 3장이 동시에 공개되는 단계. 두 번째 베팅 라운드가 진행된다.'),
      _row('Turn', '네 번째 커뮤니티 카드가 공개되는 단계. 세 번째 베팅 라운드.'),
      _row('River', '다섯 번째(마지막) 커뮤니티 카드가 공개되는 단계. 최종 베팅 라운드.'),
      _row('Showdown', '최종 베팅 후 남은 플레이어들이 카드를 공개하여 승자를 결정하는 과정.'),
      // Card diagram
      _streetsDiagram(),
    ]);
  }

  Widget _streetsDiagram() {
    return Builder(builder: (context) {
      final sw = MediaQuery.of(context).size.width;
      final cardW = (sw * 0.09).clamp(44.0, 72.0);
      final cardH = cardW * 1.42;
      final gap = cardW * 0.15;
      final labelSize = (sw * 0.015).clamp(10.0, 16.0);

      return Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF0E2E0E),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.green.shade900),
          ),
          child: Column(
            children: [
              Text('COMMUNITY CARDS', style: TextStyle(color: Colors.white24, fontSize: labelSize, letterSpacing: 4)),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Flop (3 cards)
                  _PokerCard('A', '♥', width: cardW, height: cardH),
                  SizedBox(width: gap),
                  _PokerCard('K', '♦', width: cardW, height: cardH),
                  SizedBox(width: gap),
                  _PokerCard('7', '♠', width: cardW, height: cardH),
                  SizedBox(width: gap * 2),
                  // Turn
                  _PokerCard('J', '♣', width: cardW, height: cardH),
                  SizedBox(width: gap * 2),
                  // River
                  _PokerCard('2', '♥', width: cardW, height: cardH),
                ],
              ),
              const SizedBox(height: 12),
              // Labels
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: cardW * 3 + gap * 2,
                    child: Center(child: Text('FLOP', style: TextStyle(color: Colors.amber, fontSize: labelSize, fontWeight: FontWeight.bold, letterSpacing: 2))),
                  ),
                  SizedBox(width: gap * 2),
                  SizedBox(
                    width: cardW,
                    child: Center(child: Text('TURN', style: TextStyle(color: Colors.cyan, fontSize: labelSize, fontWeight: FontWeight.bold, letterSpacing: 2))),
                  ),
                  SizedBox(width: gap * 2),
                  SizedBox(
                    width: cardW,
                    child: Center(child: Text('RIVER', style: TextStyle(color: Colors.red.shade300, fontSize: labelSize, fontWeight: FontWeight.bold, letterSpacing: 2))),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  // ===== HANDS (2-column grid, no scroll) =====
  Widget _buildHandsPage(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final termFs = (sw * 0.022).clamp(14.0, 28.0);
    final descFs = (sw * 0.014).clamp(11.0, 17.0);
    final cardW = (sw * 0.03).clamp(24.0, 40.0);
    final cardH = cardW * 1.42;

    final hands = [
      ['Pocket Pair', '같은 숫자 2장', 'A', '♠', 'A', '♥'],
      ['Suited', '같은 무늬', 'A', '♠', 'K', '♠'],
      ['Offsuit', '다른 무늬', 'A', '♠', 'K', '♥'],
      ['Suited\nConnector', '같은 무늬+연속 숫자', '8', '♥', '9', '♥'],
      ['Offsuit\nConnector', '다른 무늬+연속 숫자', 'T', '♣', 'J', '♦'],
      ['Gap\nConnector', '한 칸 건너뛴 연속', '9', '♠', 'J', '♠'],
    ];

    const rows = 3; // 6 items / 2 columns
    const spacing = 12.0;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _subtitle('핸드 타입'),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final availH = constraints.maxHeight;
                final cellH = (availH - spacing * (rows - 1)) / rows;
                final cellW = (constraints.maxWidth - 16) / 2;
                return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: spacing,
                    childAspectRatio: cellW / cellH,
                  ),
                  itemCount: hands.length,
                  itemBuilder: (context, i) {
                    final h = hands[i];
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(h[0], style: GoogleFonts.orbitron(color: Colors.red.shade500, fontSize: termFs, fontWeight: FontWeight.w800, height: 1.2)),
                                const SizedBox(height: 4),
                                Text(h[1], style: TextStyle(color: Colors.white60, fontSize: descFs)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          _CardRow([[h[2], h[3]], [h[4], h[5]]], cardWidth: cardW, cardHeight: cardH),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ===== POSITIONS (text left, diagram right) =====
  Widget _buildPositionsPage(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final termFs = (sw * 0.018).clamp(12.0, 22.0);
    final descFs = (sw * 0.013).clamp(10.0, 16.0);

    final positions = [
      ['SB', 'Small Blind', Colors.blue],
      ['BB', 'Big Blind', Colors.indigo],
      ['UTG', '얼리. 가장 먼저 액션', Colors.red.shade700],
      ['UTG+1', '얼리. UTG 다음', Colors.red.shade400],
      ['LJ', '미들. 로우잭', Colors.orange],
      ['HJ', '미들~레이트. 하이잭', Colors.amber.shade700],
      ['CO', '레이트. 컷오프', Colors.green],
      ['BTN', '레이트. 딜러버튼. 최고 포지션', Colors.teal],
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Left: position list
          SizedBox(
            width: sw * 0.32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _subtitle('포지션 (8-MAX)'),
                ...positions.map((p) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Container(
                            width: termFs * 2.2,
                            height: termFs * 2.2,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (p[2] as Color),
                            ),
                            child: Center(
                              child: Text(
                                (p[0] as String).length <= 3 ? p[0] as String : (p[0] as String).substring(0, 2),
                                style: TextStyle(color: Colors.white, fontSize: descFs, fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(p[0] as String, style: GoogleFonts.orbitron(color: Colors.red.shade500, fontSize: termFs, fontWeight: FontWeight.w700)),
                                Text(p[1] as String, style: TextStyle(color: Colors.white54, fontSize: descFs)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Right: table diagram
          Expanded(child: _positionDiagram()),
        ],
      ),
    );
  }

  Widget _positionDiagram() {
    return Builder(builder: (context) {
      final sw = MediaQuery.of(context).size.width;
      final tableW = (sw * 0.85).clamp(300.0, 600.0);
      final tableH = tableW * 0.7;
      final seatSize = (sw * 0.055).clamp(28.0, 48.0);
      final fontSize = (sw * 0.013).clamp(8.0, 13.0);

      // 8 seats positioned around an oval table
      // Positions (clockwise from bottom-center): BTN, SB, BB, UTG, UTG+1, LJ, HJ, CO
      final seats = <_SeatInfo>[
        _SeatInfo('BTN', 'D', Colors.teal, 0.50, 0.92),
        _SeatInfo('SB', 'SB', Colors.blue, 0.18, 0.80),
        _SeatInfo('BB', 'BB', Colors.indigo, 0.05, 0.55),
        _SeatInfo('UTG', '', Colors.red.shade700, 0.10, 0.25),
        _SeatInfo('UTG+1', '', Colors.red.shade400, 0.28, 0.05),
        _SeatInfo('LJ', '', Colors.orange, 0.55, 0.02),
        _SeatInfo('HJ', '', Colors.amber.shade700, 0.78, 0.15),
        _SeatInfo('CO', '', Colors.green, 0.88, 0.42),
      ];

      return Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 8),
        child: Center(
          child: SizedBox(
            width: tableW,
            height: tableH + seatSize,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Table surface
                Positioned(
                  left: seatSize * 0.5,
                  top: seatSize * 0.5,
                  child: Container(
                    width: tableW - seatSize,
                    height: tableH - seatSize * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(tableH * 0.45),
                      color: const Color(0xFF1B5E20),
                      border: Border.all(color: const Color(0xFF3E2723), width: 6),
                      boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 12)],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('8-MAX', style: GoogleFonts.orbitron(color: Colors.white24, fontSize: fontSize * 1.4, fontWeight: FontWeight.w700, letterSpacing: 3)),
                          const SizedBox(height: 4),
                          // Arrows showing action direction
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _posLabel('얼리', Colors.red.shade300, fontSize),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                child: Icon(Icons.arrow_forward, color: Colors.white24, size: fontSize * 1.2),
                              ),
                              _posLabel('미들', Colors.orange.shade300, fontSize),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                child: Icon(Icons.arrow_forward, color: Colors.white24, size: fontSize * 1.2),
                              ),
                              _posLabel('레이트', Colors.green.shade300, fontSize),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Seats
                ...seats.map((s) => Positioned(
                      left: s.x * (tableW - seatSize),
                      top: s.y * (tableH - seatSize * 0.3),
                      child: _buildSeat(s, seatSize, fontSize),
                    )),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _posLabel(String text, Color color, double fontSize) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: fontSize * 0.5, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: color.withValues(alpha: 0.15),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(text, style: TextStyle(color: color, fontSize: fontSize * 0.9, fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildSeat(_SeatInfo seat, double size, double fontSize) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: seat.color,
            boxShadow: [BoxShadow(color: seat.color.withValues(alpha: 0.5), blurRadius: 6)],
          ),
          child: Center(
            child: Text(
              seat.chip.isNotEmpty ? seat.chip : seat.label.length <= 2 ? seat.label : seat.label.substring(0, 2),
              style: TextStyle(color: Colors.white, fontSize: fontSize * 1.1, fontWeight: FontWeight.w900),
            ),
          ),
        ),
        const SizedBox(height: 3),
        Text(seat.label, style: TextStyle(color: Colors.white70, fontSize: fontSize, fontWeight: FontWeight.w600)),
      ],
    );
  }

  // ===== RANKINGS (2-column grid, no scroll) =====
  Widget _buildRankingsPage(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final termFs = (sw * 0.018).clamp(12.0, 24.0);
    final descFs = (sw * 0.012).clamp(10.0, 16.0);
    final cardW = (sw * 0.025).clamp(20.0, 36.0);
    final cardH = cardW * 1.42;

    final ranks = [
      ['High Card', '아무 조합도 없음', 'A', '♠', '8', '♥', '5', '♦', '3', '♣', '2', '♠'],
      ['One Pair', '같은 숫자 2장', 'K', '♠', 'K', '♥', '9', '♦', '5', '♣', '2', '♠'],
      ['Two Pair', '같은 숫자 2장 × 2세트', 'Q', '♠', 'Q', '♥', '7', '♦', '7', '♣', '3', '♠'],
      ['Three of a Kind', '같은 숫자 3장 (트립스/셋)', 'J', '♠', 'J', '♥', 'J', '♦', '8', '♣', '2', '♠'],
      ['Straight', '연속된 숫자 5장', '5', '♠', '6', '♥', '7', '♦', '8', '♣', '9', '♠'],
      ['Flush', '같은 무늬 5장', 'A', '♥', 'T', '♥', '8', '♥', '5', '♥', '2', '♥'],
      ['Full House', '3장 + 2장 조합', 'A', '♠', 'A', '♥', 'A', '♦', 'K', '♣', 'K', '♠'],
      ['Four of a Kind', '같은 숫자 4장 (쿼드)', '9', '♠', '9', '♥', '9', '♦', '9', '♣', 'A', '♠'],
      ['Straight Flush', '같은 무늬 + 연속 숫자', '5', '♥', '6', '♥', '7', '♥', '8', '♥', '9', '♥'],
      ['Royal Flush', 'T-J-Q-K-A 같은 무늬', 'T', '♠', 'J', '♠', 'Q', '♠', 'K', '♠', 'A', '♠'],
    ];

    const rows = 5; // 10 items / 2 columns
    const spacing = 10.0;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _subtitle('족보 (약 → 강)'),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final availH = constraints.maxHeight;
                final cellH = (availH - spacing * (rows - 1)) / rows;
                final cellW = (constraints.maxWidth - 16) / 2;
                return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: spacing,
                    childAspectRatio: cellW / cellH,
                  ),
                  itemCount: ranks.length,
                  itemBuilder: (context, i) {
                    final r = ranks[i];
                    final cards = <List<String>>[];
                    for (int j = 2; j < r.length; j += 2) {
                      cards.add([r[j], r[j + 1]]);
                    }
                    return Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${i + 1}. ',
                                style: TextStyle(color: Colors.white24, fontSize: termFs, fontWeight: FontWeight.w600),
                              ),
                              Expanded(
                                child: Text(r[0], style: GoogleFonts.orbitron(color: Colors.red.shade500, fontSize: termFs, fontWeight: FontWeight.w800, height: 1.2)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(r[1], style: TextStyle(color: Colors.white54, fontSize: descFs)),
                          const SizedBox(height: 6),
                          _CardRow(cards, cardWidth: cardW, cardHeight: cardH),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ===== Shared Helpers =====
  Widget _pageList(BuildContext context, String subtitle, List<Widget> children) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      children: [_subtitle(subtitle), ...children],
    );
  }

  Widget _subtitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(text, style: const TextStyle(color: Colors.white24, fontSize: 16, letterSpacing: 4)),
    );
  }

  Widget _row(String term, String desc) {
    return Builder(builder: (context) {
      final sw = MediaQuery.of(context).size.width;
      final termW = (sw * 0.28).clamp(110.0, 220.0);
      final termFs = (sw * 0.045).clamp(22.0, 48.0);
      final descFs = (sw * 0.022).clamp(14.0, 22.0);

      return Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: termW,
              child: Text(term, style: GoogleFonts.orbitron(color: Colors.red.shade500, fontSize: termFs, fontWeight: FontWeight.w800, height: 1.2)),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(desc, style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: descFs, height: 1.6)),
            ),
          ],
        ),
      );
    });
  }
}

class _SeatInfo {
  final String label;
  final String chip;
  final Color color;
  final double x;
  final double y;

  const _SeatInfo(this.label, this.chip, this.color, this.x, this.y);
}
