import 'package:flutter/material.dart';
import 'package:capital_mobile_app/core/theme/app_theme.dart';

class IntroducerLeaderboardScreen extends StatelessWidget {
  const IntroducerLeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
        backgroundColor: AppTheme.introducerColor,
      ),
      body: Column(
        children: [
          // Top 3 Podium
          Container(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.introducerColor, AppTheme.introducerColor.withValues(alpha: 0.8)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                const Text('Monthly Rankings', style: TextStyle(color: Colors.white70, fontSize: 14)),
                const SizedBox(height: 4),
                const Text('February 2026', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _PodiumItem(rank: 2, name: 'Rashid K.', value: 'AED 8.2M', height: 80),
                    _PodiumItem(rank: 1, name: 'Ahmed M.', value: 'AED 12.5M', height: 110, isHighlighted: true),
                    _PodiumItem(rank: 3, name: 'Susan L.', value: 'AED 6.1M', height: 64),
                  ],
                ),
              ],
            ),
          ),
          // Your Rank
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.secondaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.secondaryColor.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppTheme.secondaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text('#1', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Your Rank', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      Text('Ahmed M. (You)', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                    ],
                  ),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('AED 12.5M', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppTheme.introducerColor)),
                    Text('AUM Generated', style: TextStyle(fontSize: 11, color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
          // Full Rankings
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 15,
              itemBuilder: (context, index) {
                final rank = index + 4;
                final names = ['Omar H.', 'Lily W.', 'Faisal A.', 'Nina P.', 'Ali R.', 'Grace T.', 'Hassan M.', 'Anna K.', 'Tariq S.', 'Maria J.', 'Yusuf B.', 'Diana C.', 'Imran Q.', 'Sophia E.', 'Nawaz I.'];
                final values = ['5.8M', '5.2M', '4.9M', '4.5M', '4.1M', '3.8M', '3.5M', '3.2M', '2.9M', '2.6M', '2.3M', '2.0M', '1.8M', '1.5M', '1.2M'];
                return Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 28,
                        child: Text(
                          '#$rank',
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.grey),
                        ),
                      ),
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: AppTheme.introducerColor.withValues(alpha: 0.1),
                        child: Text(names[index][0], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.introducerColor)),
                      ),
                      const SizedBox(width: 10),
                      Expanded(child: Text(names[index], style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14))),
                      Text('AED ${values[index]}', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppTheme.introducerColor)),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PodiumItem extends StatelessWidget {
  final int rank;
  final String name;
  final String value;
  final double height;
  final bool isHighlighted;

  const _PodiumItem({
    required this.rank,
    required this.name,
    required this.value,
    required this.height,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isHighlighted)
          const Icon(Icons.emoji_events, color: AppTheme.secondaryColor, size: 28),
        const SizedBox(height: 4),
        CircleAvatar(
          radius: isHighlighted ? 28 : 22,
          backgroundColor: Colors.white.withValues(alpha: 0.2),
          child: Text(name[0], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: isHighlighted ? 20 : 16)),
        ),
        const SizedBox(height: 6),
        Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
        Text(value, style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 11)),
        const SizedBox(height: 6),
        Container(
          width: 60,
          height: height,
          decoration: BoxDecoration(
            color: isHighlighted ? AppTheme.secondaryColor : Colors.white.withValues(alpha: 0.2),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Center(
            child: Text('#$rank', style: TextStyle(color: isHighlighted ? Colors.white : Colors.white70, fontWeight: FontWeight.bold, fontSize: 18)),
          ),
        ),
      ],
    );
  }
}
