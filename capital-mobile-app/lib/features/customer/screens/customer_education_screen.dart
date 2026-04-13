import 'package:flutter/material.dart';
import 'package:capital_mobile_app/core/theme/app_theme.dart';
import 'package:capital_mobile_app/core/widgets/section_header.dart';

class CustomerEducationScreen extends StatelessWidget {
  const CustomerEducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Knowledge Center'),
        backgroundColor: AppTheme.customerColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Featured Article
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.primaryColor, AppTheme.primaryColor.withValues(alpha: 0.8)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: AppTheme.secondaryColor, borderRadius: BorderRadius.circular(6)),
                    child: const Text('FEATURED', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                  const SizedBox(height: 12),
                  const Text('The Power of Compounding:\nYour Greatest Wealth Ally', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white, height: 1.3)),
                  const SizedBox(height: 8),
                  Text('Learn how starting early and staying consistent can multiply your wealth exponentially.', style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.8))),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.secondaryColor, foregroundColor: Colors.white),
                    child: const Text('Read Now'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Categories
            const SectionHeader(title: 'Topics'),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _TopicChip('All', true),
                  _TopicChip('Investing 101', false),
                  _TopicChip('Risk Management', false),
                  _TopicChip('Behavioral Finance', false),
                  _TopicChip('Tax Planning', false),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Articles
            const SectionHeader(title: 'Recent Articles'),
            const SizedBox(height: 8),
            _ArticleCard(
              title: 'Understanding Risk Profiles',
              description: 'What does it mean to be conservative, moderate, or aggressive?',
              readTime: '5 min read',
              category: 'Investing 101',
            ),
            _ArticleCard(
              title: 'Diversification: Don\'t Put All Eggs in One Basket',
              description: 'Why spreading your investments matters for long-term success.',
              readTime: '7 min read',
              category: 'Risk Management',
            ),
            _ArticleCard(
              title: 'Emotional Investing: The Silent Wealth Killer',
              description: 'How fear and greed can derail even the best investment plans.',
              readTime: '6 min read',
              category: 'Behavioral Finance',
            ),
            _ArticleCard(
              title: 'ETF vs Mutual Funds: Which Is Right for You?',
              description: 'A comparison of costs, performance, and tax implications.',
              readTime: '8 min read',
              category: 'Investing 101',
            ),
            const SizedBox(height: 24),

            // Video Section
            const SectionHeader(title: 'Video Tutorials'),
            const SizedBox(height: 8),
            SizedBox(
              height: 160,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _VideoCard('How to Read Your Portfolio Report', '12:30'),
                  _VideoCard('Setting Financial Goals', '8:45'),
                  _VideoCard('Market Cycles Explained', '15:20'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopicChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  const _TopicChip(this.label, this.isSelected);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: Chip(
        label: Text(label, style: TextStyle(fontSize: 12, color: isSelected ? Colors.white : AppTheme.customerColor)),
        backgroundColor: isSelected ? AppTheme.customerColor : AppTheme.customerColor.withValues(alpha: 0.1),
        side: BorderSide.none,
      ),
    );
  }
}

class _ArticleCard extends StatelessWidget {
  final String title;
  final String description;
  final String readTime;
  final String category;
  const _ArticleCard({required this.title, required this.description, required this.readTime, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: AppTheme.customerColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)),
                child: Text(category, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppTheme.customerColor)),
              ),
              const Spacer(),
              Text(readTime, style: const TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
          const SizedBox(height: 4),
          Text(description, style: const TextStyle(fontSize: 13, color: Colors.grey, height: 1.3)),
        ],
      ),
    );
  }
}

class _VideoCard extends StatelessWidget {
  final String title;
  final String duration;
  const _VideoCard(this.title, this.duration);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14)),
            ),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: AppTheme.customerColor.withValues(alpha: 0.8), shape: BoxShape.circle),
                child: const Icon(Icons.play_arrow, color: Colors.white, size: 24),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(child: Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600), maxLines: 2, overflow: TextOverflow.ellipsis)),
                const SizedBox(width: 4),
                Text(duration, style: const TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
