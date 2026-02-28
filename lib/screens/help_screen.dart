import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  static const _pages = [
    _HelpPage(
      title: 'BASICS',
      subtitle: '기본 용어',
      entries: [
        _HelpEntry('SB', 'Small Blind. 딜러 왼쪽 첫 번째 플레이어가 강제로 베팅하는 금액. BB의 절반이 일반적.'),
        _HelpEntry('BB', 'Big Blind. 딜러 왼쪽 두 번째 플레이어가 강제로 베팅하는 금액. 해당 레벨의 최소 베팅 단위.'),
        _HelpEntry('Ante', '모든 플레이어가 매 핸드 시작 전 내는 강제 베팅. 액션을 유도하기 위해 중후반부터 적용.'),
        _HelpEntry('Dealer', '딜러 버튼(D)을 가진 포지션. 매 핸드마다 시계 방향으로 이동하며, 베팅 순서의 기준이 된다.'),
        _HelpEntry('Level', '블라인드 단계. 일정 시간이 지나면 다음 레벨로 올라가며 SB/BB/Ante가 증가한다.'),
        _HelpEntry('Break', '휴식 시간. 몇 레벨마다 주어지며, 이 시간 동안 게임이 중단된다.'),
        _HelpEntry('Pot', '현재 핸드에서 모든 플레이어가 베팅한 칩의 총합.'),
      ],
    ),
    _HelpPage(
      title: 'ACTIONS',
      subtitle: '액션',
      entries: [
        _HelpEntry('Fold', '패를 포기하고 해당 핸드에서 빠지는 것. 이미 베팅한 칩은 돌려받을 수 없다.'),
        _HelpEntry('Check', '베팅 없이 차례를 넘기는 것. 앞에 베팅이 없을 때만 가능.'),
        _HelpEntry('Call', '이전 플레이어의 베팅 금액과 동일하게 따라 베팅하는 것.'),
        _HelpEntry('Bet', '해당 라운드에서 첫 번째로 칩을 거는 것. 이후 다른 플레이어가 콜/레이즈/폴드를 선택.'),
        _HelpEntry('Raise', '이전 베팅보다 더 높은 금액으로 베팅하는 것. 최소 레이즈는 직전 레이즈 폭 이상.'),
        _HelpEntry('Re-raise', '레이즈에 대해 다시 레이즈하는 것. 3-Bet, 4-Bet 등으로도 불린다.'),
        _HelpEntry('All-in', '보유한 칩 전부를 베팅하는 것. 올인 후에는 추가 베팅 없이 쇼다운까지 진행.'),
      ],
    ),
    _HelpPage(
      title: 'STREETS',
      subtitle: '게임 진행 단계',
      entries: [
        _HelpEntry('Preflop', '커뮤니티 카드가 깔리기 전 단계. 각 플레이어는 2장의 홀카드를 받고 첫 베팅을 진행.'),
        _HelpEntry('Flop', '커뮤니티 카드 3장이 동시에 공개되는 단계. 두 번째 베팅 라운드가 진행된다.'),
        _HelpEntry('Turn', '네 번째 커뮤니티 카드가 공개되는 단계. 세 번째 베팅 라운드.'),
        _HelpEntry('River', '다섯 번째(마지막) 커뮤니티 카드가 공개되는 단계. 최종 베팅 라운드.'),
        _HelpEntry('Showdown', '최종 베팅 후 남은 플레이어들이 카드를 공개하여 승자를 결정하는 과정.'),
      ],
    ),
    _HelpPage(
      title: 'HANDS',
      subtitle: '핸드 타입',
      entries: [
        _HelpEntry('Pocket\nPair', '두 장의 홀카드가 같은 숫자인 경우.\n예: AA, KK, QQ, JJ, 22 등. 프리미엄 핸드에 해당.'),
        _HelpEntry('Suited', '두 장의 홀카드가 같은 무늬인 경우.\n예: A♠K♠, 7♥8♥. 플러시 가능성이 있어 가치가 높아진다.'),
        _HelpEntry('Offsuit', '두 장의 홀카드가 다른 무늬인 경우.\n예: A♠K♥. 같은 숫자 조합이라도 수딧보다 가치가 낮다.'),
        _HelpEntry('Connec\ntor', '두 장의 홀카드가 연속된 숫자인 경우.\n예: 8♠9♠(수딧 커넥터), T♥J♣(오프숫 커넥터). 스트레이트 가능성.'),
      ],
    ),
    _HelpPage(
      title: 'POSITIONS',
      subtitle: '포지션',
      entries: [
        _HelpEntry('UTG', 'Under The Gun. BB 왼쪽, 프리플랍에서 가장 먼저 액션하는 자리. 가장 불리한 포지션.'),
        _HelpEntry('MP', 'Middle Position. UTG와 레이트 포지션 사이. 중간 정도의 핸드 레인지로 플레이.'),
        _HelpEntry('CO', 'Cutoff. 딜러 바로 오른쪽. 레이트 포지션으로 넓은 레인지 플레이 가능.'),
        _HelpEntry('BTN', 'Button(딜러). 포스트플랍에서 항상 마지막에 액션. 가장 유리한 포지션.'),
        _HelpEntry('SB', 'Small Blind 포지션. 프리플랍에서는 마지막에 가깝지만, 포스트플랍에서 가장 먼저 액션.'),
        _HelpEntry('BB', 'Big Blind 포지션. 프리플랍에서 마지막에 액션. 포스트플랍에서는 SB 다음으로 액션.'),
      ],
    ),
    _HelpPage(
      title: 'RANKINGS',
      subtitle: '족보 (약 → 강)',
      entries: [
        _HelpEntry('High\nCard', '아무 조합도 없는 경우. 가장 높은 카드로 승부.\n예: A♠8♥5♦3♣2♠'),
        _HelpEntry('One\nPair', '같은 숫자 2장.\n예: K♠K♥9♦5♣2♠'),
        _HelpEntry('Two\nPair', '같은 숫자 2장이 두 세트.\n예: Q♠Q♥7♦7♣3♠'),
        _HelpEntry('Three\nof a Kind', '같은 숫자 3장. "트립스" 또는 "셋"이라고도 함.\n예: J♠J♥J♦8♣2♠'),
        _HelpEntry('Straight', '연속된 숫자 5장. 무늬 무관.\n예: 5♠6♥7♦8♣9♠'),
        _HelpEntry('Flush', '같은 무늬 5장. 숫자 무관.\n예: A♥T♥8♥5♥2♥'),
        _HelpEntry('Full\nHouse', '같은 숫자 3장 + 같은 숫자 2장.\n예: A♠A♥A♦K♣K♠'),
        _HelpEntry('Four of\na Kind', '같은 숫자 4장. "쿼드"라고도 함.\n예: 9♠9♥9♦9♣A♠'),
        _HelpEntry('Straight\nFlush', '같은 무늬로 연속된 숫자 5장.\n예: 5♥6♥7♥8♥9♥'),
        _HelpEntry('Royal\nFlush', '같은 무늬의 T, J, Q, K, A. 최강 족보.\n예: T♠J♠Q♠K♠A♠'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _pages.length,
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
            tabs: _pages.map((p) => Tab(text: p.title)).toList(),
          ),
        ),
        body: TabBarView(
          children: _pages.map((page) => _buildPage(context, page)).toList(),
        ),
      ),
    );
  }

  Widget _buildPage(BuildContext context, _HelpPage page) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      itemCount: page.entries.length + 1, // +1 for subtitle header
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              page.subtitle,
              style: TextStyle(
                color: Colors.white24,
                fontSize: 16,
                letterSpacing: 4,
              ),
            ),
          );
        }
        final entry = page.entries[index - 1];
        return _buildRow(context, entry);
      },
    );
  }

  Widget _buildRow(BuildContext context, _HelpEntry entry) {
    final screenWidth = MediaQuery.of(context).size.width;
    final termWidth = (screenWidth * 0.25).clamp(100.0, 200.0);
    final termFontSize = (screenWidth * 0.045).clamp(22.0, 48.0);
    final descFontSize = (screenWidth * 0.025).clamp(15.0, 24.0);

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Term (left)
          SizedBox(
            width: termWidth,
            child: Text(
              entry.term,
              style: GoogleFonts.orbitron(
                color: Colors.red.shade500,
                fontSize: termFontSize,
                fontWeight: FontWeight.w800,
                height: 1.2,
              ),
            ),
          ),
          const SizedBox(width: 24),
          // Description (right)
          Expanded(
            child: Text(
              entry.description,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: descFontSize,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HelpPage {
  final String title;
  final String subtitle;
  final List<_HelpEntry> entries;

  const _HelpPage({required this.title, required this.subtitle, required this.entries});
}

class _HelpEntry {
  final String term;
  final String description;

  const _HelpEntry(this.term, this.description);
}
