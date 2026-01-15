import 'package:flutter/material.dart';
import 'package:rungokno_tembang/pages/login_page.dart';
import 'package:rungokno_tembang/theme/app_theme.dart';
import 'package:rungokno_tembang/services/navigation_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rungokno Tembang',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const LoginPage(),
      navigatorKey: NavigationService.navigatorKey,
      onGenerateRoute: NavigationService.generateRoute,
    );
  }
}