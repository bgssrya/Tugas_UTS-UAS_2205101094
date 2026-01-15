import 'package:flutter/material.dart';

import 'package:rungokno_tembang/pages/explore_page.dart';
import 'package:rungokno_tembang/pages/home_page.dart';
import 'package:rungokno_tembang/pages/library_page.dart';
import 'package:rungokno_tembang/pages/login_page.dart';
import 'package:rungokno_tembang/pages/music_player_page.dart';
import 'package:rungokno_tembang/pages/profile_page.dart';

import 'package:rungokno_tembang/models/music_model.dart'; // ✅ WAJIB

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());

      case '/explore':
        return MaterialPageRoute(builder: (_) => const ExplorePage());

      case '/library':
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => LibraryPage(arguments: args),
        );

      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfilePage());

      case '/player':
        final music = settings.arguments as Music;
        return MaterialPageRoute(
          builder: (_) => MusicPlayerPage(music: music),
        );

      default:
        return MaterialPageRoute(builder: (_) => const LoginPage());
    }
  }

  static Future<dynamic> navigateTo(
    String routeName, {
    Object? arguments,
  }) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  static Future<dynamic> navigateReplacement(
    String routeName, {
    Object? arguments,
  }) {
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  static void goBack() {
    navigatorKey.currentState!.pop();
  }

  static Future<dynamic> navigateAndRemoveUntil(String routeName) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
    );
  }
}
