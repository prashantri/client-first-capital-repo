import 'package:flutter/material.dart';
import 'package:capital_mobile_app/core/theme/app_theme.dart';
import 'package:capital_mobile_app/core/widgets/section_header.dart';

class IntroducerMarketingScreen extends StatelessWidget {
  const IntroducerMarketingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marketing Materials'),
        backgroundColor: AppTheme.introducerColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Auto-share Content
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.introducerColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.introducerColor.withValues(alpha: 0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.auto_awesome, color: AppTheme.introducerColor),
                      const SizedBox(width: 8),
                      const Text('Auto-Share Wealth Content', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text('Automatically share curated wealth insights to your network weekly or monthly.',
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(backgroundColor: AppTheme.introducerColor),
                        child: const Text('Enable Weekly'),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton(
                        onPressed: () {},
                        child: const Text('Monthly'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Downloadable Materials
            const SectionHeader(title: 'Brochures & Presentations'),
            const SizedBox(height: 8),
            _MaterialItem(icon: Icons.picture_as_pdf, title: 'Company Overview Brochure', size: '2.1 MB', type: 'PDF'),
            _MaterialItem(icon: Icons.slideshow, title: 'Investment Strategy Deck', size: '4.5 MB', type: 'PPTX'),
            _MaterialItem(icon: Icons.picture_as_pdf, title: 'Risk Management Guide', size: '1.8 MB', type: 'PDF'),
            _MaterialItem(icon: Icons.picture_as_pdf, title: 'Fee Structure Overview', size: '0.9 MB', type: 'PDF'),
            const SizedBox(height: 24),

            // Social Media Content
            const SectionHeader(title: 'Social Media Posts'),
            const SizedBox(height: 8),
            _SocialPostCard(
              title: 'Wealth Building Tips',
              description: 'Ready-to-share posts about disciplined investing and compounding.',
              count: '12 posts',
            ),
            _SocialPostCard(
              title: 'Market Insights',
              description: 'Weekly market commentary and analysis posts.',
              count: '8 posts',
            ),
            _SocialPostCard(
              title: 'Success Stories',
              description: 'Client testimonials and journey highlights.',
              count: '6 posts',
            ),
            const SizedBox(height: 24),

            // Educational Quotes
            const SectionHeader(title: 'Weekly Quotes & Insights'),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Icon(Icons.format_quote, color: AppTheme.secondaryColor, size: 32),
                  const SizedBox(height: 8),
                  const Text(
                    '"The stock market is a device for transferring money from the impatient to the patient."',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 16, fontStyle: FontStyle.italic, height: 1.5),
                  ),
                  const SizedBox(height: 12),
                  Text('— Warren Buffett', style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 13)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.share, size: 16, color: Colors.white),
                        label: const Text('Share', style: TextStyle(color: Colors.white)),
                        style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.white.withValues(alpha: 0.3))),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.skip_next, size: 16, color: Colors.white),
                        label: const Text('Next', style: TextStyle(color: Colors.white)),
                        style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.white.withValues(alpha: 0.3))),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MaterialItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String size;
  final String type;

  const _MaterialItem({required this.icon, required this.title, required this.size, required this.type});

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
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.red.shade700, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                Text('$type • $size', style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.download, color: AppTheme.introducerColor),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _SocialPostCard extends StatelessWidget {
  final String title;
  final String description;
  final String count;

  const _SocialPostCard({required this.title, required this.description, required this.count});

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
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.auto_stories, color: Colors.blue, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                Text(description, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.introducerColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(count, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.introducerColor)),
          ),
        ],
      ),
    );
  }
}
