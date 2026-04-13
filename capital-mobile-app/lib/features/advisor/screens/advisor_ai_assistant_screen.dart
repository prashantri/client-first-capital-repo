import 'package:flutter/material.dart';
import 'package:capital_mobile_app/core/theme/app_theme.dart';

class AdvisorAIAssistantScreen extends StatelessWidget {
  const AdvisorAIAssistantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Portfolio Assistant'),
        backgroundColor: AppTheme.advisorColor,
      ),
      body: Column(
        children: [
          // Chat Messages
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _AIMessage(
                  message: "Hello Fatima! I'm your AI Portfolio Assistant. I can help you with:\n\n"
                      "• Portfolio analysis & explanations\n"
                      "• Risk assessment insights\n"
                      "• Client meeting preparation\n"
                      "• Market commentary drafting\n\n"
                      "What would you like help with today?",
                ),
                _UserMessage(message: "Can you give me a summary of Sarah Johnson's portfolio performance?"),
                _AIMessage(
                  message: "📊 **Sarah Johnson — Portfolio Summary**\n\n"
                      "**Total Value:** AED 2,500,000\n"
                      "**YTD Return:** +8.5% (vs benchmark +6.2%)\n"
                      "**Risk Profile:** Moderate\n\n"
                      "**Allocation:**\n"
                      "• Equities: 55% (+12.3%)\n"
                      "• Fixed Income: 25% (+3.1%)\n"
                      "• Real Estate: 10% (+5.8%)\n"
                      "• Cash: 10%\n\n"
                      "**Key Observations:**\n"
                      "✅ Outperforming benchmark by 2.3%\n"
                      "⚠️ Equity allocation slightly above target (55% vs 50%)\n"
                      "💡 Consider rebalancing to maintain moderate risk profile\n\n"
                      "Would you like me to prepare talking points for your next meeting?",
                ),
                _UserMessage(message: "Yes, prepare meeting talking points"),
                _AIMessage(
                  message: "📋 **Meeting Talking Points — Sarah Johnson**\n\n"
                      "**1. Performance Highlight:**\n"
                      "\"Your portfolio has returned +8.5% year-to-date, outperforming the benchmark by 2.3%. This places you in the top 25% of similar risk profiles.\"\n\n"
                      "**2. Rebalancing Recommendation:**\n"
                      "\"I'd recommend trimming equities by 5% and adding to fixed income to maintain your moderate risk target.\"\n\n"
                      "**3. Market Outlook:**\n"
                      "\"Despite recent volatility, our long-term outlook remains positive. The diversified approach continues to protect against downside risk.\"\n\n"
                      "**4. Goal Progress:**\n"
                      "\"You're on track to reach your retirement goal of AED 5M by 2035 — currently at 50% of target.\"\n\n"
                      "Shall I save these notes to her client file?",
                ),
              ],
            ),
          ),
          // Suggested Queries
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _SuggestedChip('Risk analysis'),
                  _SuggestedChip('Rebalancing suggestion'),
                  _SuggestedChip('Market summary'),
                  _SuggestedChip('Draft email'),
                ],
              ),
            ),
          ),
          // Input Bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, -2))],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Ask about portfolio, risk, or market...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: AppTheme.advisorColor,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 18),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AIMessage extends StatelessWidget {
  final String message;
  const _AIMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12, right: 48),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.advisorColor.withValues(alpha: 0.06),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(16),
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.smart_toy, size: 16, color: AppTheme.advisorColor),
              const SizedBox(width: 6),
              Text('AI Assistant', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.advisorColor)),
            ],
          ),
          const SizedBox(height: 8),
          Text(message, style: const TextStyle(fontSize: 13, height: 1.5)),
        ],
      ),
    );
  }
}

class _UserMessage extends StatelessWidget {
  final String message;
  const _UserMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12, left: 48),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.advisorColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(4),
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Text(message, style: const TextStyle(fontSize: 13, color: Colors.white, height: 1.5)),
    );
  }
}

class _SuggestedChip extends StatelessWidget {
  final String label;
  const _SuggestedChip(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: ActionChip(
        label: Text(label, style: const TextStyle(fontSize: 12, color: AppTheme.advisorColor)),
        backgroundColor: AppTheme.advisorColor.withValues(alpha: 0.08),
        side: BorderSide(color: AppTheme.advisorColor.withValues(alpha: 0.2)),
        onPressed: () {},
      ),
    );
  }
}
