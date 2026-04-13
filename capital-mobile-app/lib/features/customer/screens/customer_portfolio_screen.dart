import 'package:flutter/material.dart';
import 'package:capital_mobile_app/core/theme/app_theme.dart';
import 'package:capital_mobile_app/core/widgets/section_header.dart';

class CustomerPortfolioScreen extends StatelessWidget {
  const CustomerPortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Portfolio Performance'),
        backgroundColor: AppTheme.customerColor,
        actions: [
          IconButton(icon: const Icon(Icons.download), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Time Period Selector
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _PeriodChip('1M', false),
                  _PeriodChip('3M', false),
                  _PeriodChip('6M', false),
                  _PeriodChip('YTD', true),
                  _PeriodChip('1Y', false),
                  _PeriodChip('ALL', false),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Performance Chart Placeholder
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: CustomPaint(
                painter: _SimpleChartPainter(),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Portfolio vs Benchmark', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                      SizedBox(height: 4),
                      Text('+12.5% vs +6.2%', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.accentColor)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Asset Allocation
            const SectionHeader(title: 'Asset Allocation'),
            const SizedBox(height: 8),
            _AllocationItem('Equities', 50, 'AED 175,000', '+15.2%', Colors.blue),
            _AllocationItem('Fixed Income', 25, 'AED 87,500', '+4.1%', Colors.green),
            _AllocationItem('Real Estate', 15, 'AED 52,500', '+8.3%', Colors.orange),
            _AllocationItem('Cash & Equivalents', 10, 'AED 35,000', '+1.5%', Colors.grey),
            const SizedBox(height: 24),

            // Top Holdings
            const SectionHeader(title: 'Top Holdings'),
            const SizedBox(height: 8),
            _HoldingItem('Vanguard S&P 500 ETF', 'VOO', '+18.5%', 'AED 45,000'),
            _HoldingItem('iShares MSCI Emerging', 'EEM', '+12.1%', 'AED 28,000'),
            _HoldingItem('UAE Blue Chip Fund', 'UAEBCF', '+9.8%', 'AED 35,000'),
            _HoldingItem('Global Bond ETF', 'BND', '+3.2%', 'AED 52,000'),
            _HoldingItem('Real Estate Fund', 'REITS', '+7.5%', 'AED 40,000'),
            const SizedBox(height: 24),

            // Download Report Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.download),
                label: const Text('Download Full Report (PDF)'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.customerColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PeriodChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  const _PeriodChip(this.label, this.isSelected);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label, style: TextStyle(fontSize: 12, color: isSelected ? Colors.white : AppTheme.customerColor)),
        selected: isSelected,
        selectedColor: AppTheme.customerColor,
        backgroundColor: AppTheme.customerColor.withValues(alpha: 0.1),
        side: BorderSide.none,
        onSelected: (_) {},
      ),
    );
  }
}

class _AllocationItem extends StatelessWidget {
  final String name;
  final int percent;
  final String value;
  final String returnPct;
  final Color color;
  const _AllocationItem(this.name, this.percent, this.value, this.returnPct, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 12, height: 12,
                decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3)),
              ),
              const SizedBox(width: 10),
              Expanded(child: Text(name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14))),
              Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const SizedBox(width: 22),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: percent / 100,
                    backgroundColor: color.withValues(alpha: 0.1),
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    minHeight: 6,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text('$percent%', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
              const SizedBox(width: 12),
              Text(returnPct, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: returnPct.startsWith('+') ? Colors.green : Colors.red)),
            ],
          ),
        ],
      ),
    );
  }
}

class _HoldingItem extends StatelessWidget {
  final String name;
  final String ticker;
  final String returnPct;
  final String value;
  const _HoldingItem(this.name, this.ticker, this.returnPct, this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: 42, height: 42,
            decoration: BoxDecoration(color: AppTheme.customerColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
            child: Center(child: Text(ticker.substring(0, 2), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppTheme.customerColor))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                Text(ticker, style: const TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              Text(returnPct, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.green)),
            ],
          ),
        ],
      ),
    );
  }
}

class _SimpleChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Simple background grid lines
    final gridPaint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.1)
      ..strokeWidth = 1;

    for (int i = 1; i < 4; i++) {
      final y = size.height * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
