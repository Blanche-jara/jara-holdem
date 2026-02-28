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

  // ===== HANDS =====
  Widget _buildHandsPage(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final termW = (sw * 0.28).clamp(110.0, 220.0);
    final termFs = (sw * 0.045).clamp(22.0, 48.0);
    final descFs = (sw * 0.022).clamp(14.0, 22.0);

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      children: [
        _subtitle('핸드 타입'),
        _handRow('Pocket\nPair', '두 장의 홀카드가 같은 숫자.\n프리미엄 핸드에 해당.', [['A', '♠'], ['A', '♥']], termW, termFs, descFs),
        _handRow('Suited', '두 장의 홀카드가 같은 무늬.\n플러시 가능성이 있어 가치 상승.', [['A', '♠'], ['K', '♠']], termW, termFs, descFs),
        _handRow('Offsuit', '두 장의 홀카드가 다른 무늬.\n같은 숫자 조합이라도 수딧보다 가치가 낮다.', [['A', '♠'], ['K', '♥']], termW, termFs, descFs),
        _handRow('Suited\nConnector', '같은 무늬 + 연속 숫자.\n스트레이트+플러시 가능성.', [['8', '♥'], ['9', '♥']], termW, termFs, descFs),
        _handRow('Offsuit\nConnector', '다른 무늬 + 연속 숫자.\n스트레이트 가능성.', [['T', '♣'], ['J', '♦']], termW, termFs, descFs),
        _handRow('Gap\nConnector', '한 칸 건너뛴 연속 숫자.\n예: 9-J (10을 건너뜀).', [['9', '♠'], ['J', '♠']], termW, termFs, descFs),
      ],
    );
  }

  Widget _handRow(String term, String desc, List<List<String>> cards, double termW, double termFs, double descFs) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: termW,
            child: Text(term, style: GoogleFonts.orbitron(color: Colors.red.shade500, fontSize: termFs, fontWeight: FontWeight.w800, height: 1.2)),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(desc, style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: descFs, height: 1.5)),
                const SizedBox(height: 10),
                _CardRow(cards, cardWidth: 42, cardHeight: 60),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===== POSITIONS =====
  Widget _buildPositionsPage(BuildContext context) {
    return _pageList(context, '포지션', [
      _row('UTG', 'Under The Gun. BB 왼쪽, 프리플랍에서 가장 먼저 액션하는 자리. 가장 불리한 포지션.'),
      _row('MP', 'Middle Position. UTG와 레이트 포지션 사이. 중간 정도의 핸드 레인지로 플레이.'),
      _row('CO', 'Cutoff. 딜러 바로 오른쪽. 레이트 포지션으로 넓은 레인지 플레이 가능.'),
      _row('BTN', 'Button(딜러). 포스트플랍에서 항상 마지막에 액션. 가장 유리한 포지션.'),
      _row('SB', 'Small Blind 포지션. 프리플랍에서는 마지막에 가깝지만, 포스트플랍에서 가장 먼저 액션.'),
      _row('BB', 'Big Blind 포지션. 프리플랍에서 마지막에 액션. 포스트플랍에서는 SB 다음으로 액션.'),
    ]);
  }

  // ===== RANKINGS =====
  Widget _buildRankingsPage(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final termW = (sw * 0.28).clamp(110.0, 220.0);
    final termFs = (sw * 0.04).clamp(20.0, 40.0);
    final descFs = (sw * 0.02).clamp(13.0, 20.0);
    final cardW = (sw * 0.05).clamp(30.0, 48.0);
    final cardH = cardW * 1.42;

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      children: [
        _subtitle('족보 (약 → 강)'),
        _rankRow('High Card', '아무 조합도 없음. 가장 높은 카드로 승부.', [['A', '♠'], ['8', '♥'], ['5', '♦'], ['3', '♣'], ['2', '♠']], termW, termFs, descFs, cardW, cardH),
        _rankRow('One Pair', '같은 숫자 2장.', [['K', '♠'], ['K', '♥'], ['9', '♦'], ['5', '♣'], ['2', '♠']], termW, termFs, descFs, cardW, cardH),
        _rankRow('Two Pair', '같은 숫자 2장 × 2세트.', [['Q', '♠'], ['Q', '♥'], ['7', '♦'], ['7', '♣'], ['3', '♠']], termW, termFs, descFs, cardW, cardH),
        _rankRow('Three of\na Kind', '같은 숫자 3장.\n"트립스" 또는 "셋".', [['J', '♠'], ['J', '♥'], ['J', '♦'], ['8', '♣'], ['2', '♠']], termW, termFs, descFs, cardW, cardH),
        _rankRow('Straight', '연속된 숫자 5장.\n무늬 무관.', [['5', '♠'], ['6', '♥'], ['7', '♦'], ['8', '♣'], ['9', '♠']], termW, termFs, descFs, cardW, cardH),
        _rankRow('Flush', '같은 무늬 5장.\n숫자 무관.', [['A', '♥'], ['T', '♥'], ['8', '♥'], ['5', '♥'], ['2', '♥']], termW, termFs, descFs, cardW, cardH),
        _rankRow('Full House', '같은 숫자 3장 +\n같은 숫자 2장.', [['A', '♠'], ['A', '♥'], ['A', '♦'], ['K', '♣'], ['K', '♠']], termW, termFs, descFs, cardW, cardH),
        _rankRow('Four of\na Kind', '같은 숫자 4장.\n"쿼드".', [['9', '♠'], ['9', '♥'], ['9', '♦'], ['9', '♣'], ['A', '♠']], termW, termFs, descFs, cardW, cardH),
        _rankRow('Straight\nFlush', '같은 무늬 +\n연속 숫자 5장.', [['5', '♥'], ['6', '♥'], ['7', '♥'], ['8', '♥'], ['9', '♥']], termW, termFs, descFs, cardW, cardH),
        _rankRow('Royal\nFlush', '같은 무늬의\nT-J-Q-K-A. 최강 족보.', [['T', '♠'], ['J', '♠'], ['Q', '♠'], ['K', '♠'], ['A', '♠']], termW, termFs, descFs, cardW, cardH),
      ],
    );
  }

  Widget _rankRow(String term, String desc, List<List<String>> cards, double termW, double termFs, double descFs, double cardW, double cardH) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: termW,
            child: Text(term, style: GoogleFonts.orbitron(color: Colors.red.shade500, fontSize: termFs, fontWeight: FontWeight.w800, height: 1.2)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(desc, style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: descFs, height: 1.5)),
                const SizedBox(height: 10),
                _CardRow(cards, cardWidth: cardW, cardHeight: cardH),
              ],
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
