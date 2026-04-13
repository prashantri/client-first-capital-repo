import 'package:flutter/material.dart';
import 'package:capital_mobile_app/core/theme/app_theme.dart';
import 'package:capital_mobile_app/screens/splash_screen.dart';
import 'package:capital_mobile_app/screens/welcome_screen.dart';
import 'package:capital_mobile_app/screens/login_screen.dart';
import 'package:capital_mobile_app/screens/role_selection_screen.dart';
import 'package:capital_mobile_app/features/introducer/screens/introducer_home_screen.dart';
import 'package:capital_mobile_app/features/introducer/screens/registration_step1_screen.dart';
import 'package:capital_mobile_app/features/introducer/screens/registration_step3_screen.dart';
import 'package:capital_mobile_app/features/introducer/screens/review_status_screen.dart';
import 'package:capital_mobile_app/features/introducer/screens/introducer_dashboard_screen.dart';
import 'package:capital_mobile_app/features/introducer/screens/referral_list_screen.dart';
import 'package:capital_mobile_app/features/introducer/screens/create_referral_screen.dart';
import 'package:capital_mobile_app/features/introducer/screens/marketing_hub_screen.dart';
import 'package:capital_mobile_app/features/introducer/screens/profile_screen.dart';
import 'package:capital_mobile_app/features/advisor/screens/advisor_home_screen.dart';
import 'package:capital_mobile_app/features/customer/screens/customer_home_screen.dart';
import 'package:capital_mobile_app/features/investor/screens/investor_home_screen.dart';

class ClientFirstCapitalApp extends StatelessWidget {
  const ClientFirstCapitalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Client First Capital',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/role-selection': (context) => const RoleSelectionScreen(),
        '/registration-step1': (context) => const RegistrationStep1Screen(),
        '/registration-step3': (context) => const RegistrationStep3Screen(),
        '/review-status': (context) => const ReviewStatusScreen(),
        '/introducer-dashboard': (context) => const IntroducerDashboardScreen(),
        '/referral-list': (context) => const ReferralListScreen(),
        '/create-referral': (context) => const CreateReferralScreen(),
        '/marketing-hub': (context) => const MarketingHubScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/introducer': (context) => const IntroducerHomeScreen(),
        '/advisor': (context) => const AdvisorHomeScreen(),
        '/customer': (context) => const CustomerHomeScreen(),
        '/investor': (context) => const InvestorHomeScreen(),
      },
    );
  }
}
