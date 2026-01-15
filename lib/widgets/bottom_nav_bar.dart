import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../services/navigation_service.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    this.onTap,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.surface.withOpacity(0.9),
            AppColors.surface,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        border: Border(
          top: BorderSide(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: (index) {
          widget.onTap?.call(index);
          _handleNavigation(index);
        },
        backgroundColor: Colors.transparent,
        selectedItemColor: AppColors.accent,
        unselectedItemColor: AppColors.onSurface,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            activeIcon: Icon(Icons.home_filled, color: AppColors.accent),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            activeIcon: Icon(Icons.explore, color: AppColors.accent),
            label: 'Jelajahi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            activeIcon: Icon(Icons.library_music, color: AppColors.accent),
            label: 'Perpustakaan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            activeIcon: Icon(Icons.person, color: AppColors.accent),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  void _handleNavigation(int index) {
    switch (index) {
      case 0:
        NavigationService.navigateTo('/home');
        break;
      case 1:
        NavigationService.navigateTo('/explore');
        break;
      case 2:
        NavigationService.navigateTo('/library');
        break;
      case 3:
        NavigationService.navigateTo('/profile');
        break;
    }
  }
}