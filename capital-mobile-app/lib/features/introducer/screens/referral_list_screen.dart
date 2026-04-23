import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:capital_mobile_app/core/theme/app_theme.dart';
import 'package:capital_mobile_app/providers/introducer_provider.dart';
import 'package:capital_mobile_app/models/referral.dart';

class ReferralListScreen extends StatefulWidget {
  const ReferralListScreen({super.key});

  @override
  State<ReferralListScreen> createState() => _ReferralListScreenState();
}

class _ReferralListScreenState extends State<ReferralListScreen> {
  String _activeFilter = 'All';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<IntroducerProvider>(context, listen: false).loadReferrals();
    });
  }

  String _mapStatus(String backendStatus) {
    switch (backendStatus) {
      case 'converted':
        return 'Approved';
      case 'lost':
        return 'Rejected';
      default:
        return 'Pending';
    }
  }

  IconData _serviceIcon(String? serviceType) {
    switch (serviceType) {
      case 'Structured Loan':
        return Icons.account_balance;
      case 'Wealth Management / Investment':
        return Icons.account_balance_wallet;
      case 'Premium Life Insurance':
        return Icons.health_and_safety;
      case 'Tax Optimization Strategy':
        return Icons.receipt_long;
      case 'Estate Planning':
        return Icons.real_estate_agent;
      default:
        return Icons.person;
    }
  }

  List<_ReferralData> _getFilteredReferrals(List<Referral> referrals) {
    final query = _searchController.text.toLowerCase();
    return referrals.where((r) {
      final displayStatus = _mapStatus(r.status);
      final matchesFilter =
          _activeFilter == 'All' || displayStatus == _activeFilter;
      final matchesSearch = query.isEmpty ||
          r.referralName.toLowerCase().contains(query) ||
          (r.serviceType?.toLowerCase().contains(query) ?? false);
      return matchesFilter && matchesSearch;
    }).map((r) => _ReferralData(
      name: r.referralName,
      service: r.serviceType ?? 'General',
      date: r.createdAt != null
          ? DateFormat('MMM dd, yyyy').format(r.createdAt!)
          : '',
      status: _mapStatus(r.status),
      icon: _serviceIcon(r.serviceType),
    )).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<IntroducerProvider>();
    final filteredReferrals = _getFilteredReferrals(provider.referrals);
    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: Column(
        children: [
          _buildAppBar(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  _buildHeader(),
                  const SizedBox(height: 24),
                  _buildSearchBar(),
                  const SizedBox(height: 20),
                  _buildFilters(),
                  const SizedBox(height: 24),
                  if (provider.isLoading && provider.referrals.isEmpty)
                    const Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ...filteredReferrals.map(_buildReferralCard),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/create-referral'),
        backgroundColor: AppTheme.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 48, left: 24, right: 24, bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(204),
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset('assets/images/logo.png', width: 24, height: 24),
              const SizedBox(width: 10),
              Text(
                'Client First Capital',
                style: GoogleFonts.manrope(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.primaryColor,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade200,
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Icon(Icons.person, size: 18, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Referrals',
          style: GoogleFonts.manrope(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: AppTheme.primaryColor,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Track and manage your introductions to Client First Capital.',
          style: GoogleFonts.inter(
            fontSize: 14,
            color: AppTheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (_) => setState(() {}),
        style: GoogleFonts.inter(fontSize: 14, color: AppTheme.onSurface),
        decoration: InputDecoration(
          hintText: 'Search leads or services...',
          hintStyle: GoogleFonts.inter(
            fontSize: 14,
            color: Colors.grey.shade400,
          ),
          prefixIcon: Icon(Icons.search, color: AppTheme.outline, size: 20),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildFilters() {
    final filters = ['All', 'Approved', 'Pending', 'Rejected'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((filter) {
          final isActive = _activeFilter == filter;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => setState(() => _activeFilter = filter),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                decoration: BoxDecoration(
                  color: isActive ? AppTheme.primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isActive
                        ? AppTheme.primaryColor
                        : Colors.grey.shade200,
                  ),
                ),
                child: Text(
                  filter,
                  style: GoogleFonts.manrope(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: isActive ? Colors.white : Colors.grey.shade600,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildReferralCard(_ReferralData referral) {
    final statusColors = {
      'Approved': (AppTheme.primaryColor, const Color(0xFFDCFCE7)),
      'Pending': (const Color(0xFF92400E), const Color(0xFFFEF9C3)),
      'Rejected': (const Color(0xFFB91C1C), const Color(0xFFFEE2E2)),
    };

    final colors = statusColors[referral.status] ??
        (AppTheme.onSurface, Colors.grey.shade100);

    final iconBgColor = referral.status == 'Approved'
        ? const Color(0xFFDCFCE7)
        : Colors.grey.shade50;
    final iconColor = referral.status == 'Approved'
        ? AppTheme.primaryColor
        : Colors.grey.shade600;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(referral.icon, color: iconColor, size: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      referral.name,
                      style: GoogleFonts.manrope(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      referral.service.toUpperCase(),
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade500,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: colors.$2,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  referral.status.toUpperCase(),
                  style: GoogleFonts.manrope(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    color: colors.$1,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey.shade50),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_today,
                        size: 14, color: Colors.grey.shade400),
                    const SizedBox(width: 6),
                    Text(
                      referral.date,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Text(
                        'View Details',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Icon(Icons.chevron_right,
                          size: 18, color: AppTheme.primaryColor),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(230),
        border: Border(
          top: BorderSide(color: Colors.grey.shade100),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(8),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.dashboard, 'Dashboard', false, () {
              Navigator.pushReplacementNamed(context, '/introducer-dashboard');
            }),
            _buildNavItem(Icons.group_add, 'Referrals', true, () {}),
            _buildNavItem(Icons.campaign, 'Marketing', false, () {
              Navigator.pushReplacementNamed(context, '/marketing-hub');
            }),
            _buildNavItem(Icons.account_circle, 'Profile', false, () {
              Navigator.pushReplacementNamed(context, '/profile');
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
      IconData icon, String label, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? AppTheme.primaryColor : Colors.grey.shade400,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label.toUpperCase(),
            style: GoogleFonts.manrope(
              fontSize: 10,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
              color: isActive ? AppTheme.primaryColor : Colors.grey.shade400,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReferralData {
  final String name;
  final String service;
  final String date;
  final String status;
  final IconData icon;

  const _ReferralData({
    required this.name,
    required this.service,
    required this.date,
    required this.status,
    required this.icon,
  });
}
