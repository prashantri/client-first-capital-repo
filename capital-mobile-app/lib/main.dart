import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capital_mobile_app/app.dart';
import 'package:capital_mobile_app/providers/auth_provider.dart';
import 'package:capital_mobile_app/providers/introducer_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => IntroducerProvider()),
      ],
      child: const ClientFirstCapitalApp(),
    ),
  );
}
