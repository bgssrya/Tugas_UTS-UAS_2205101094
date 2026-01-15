import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../services/navigation_service.dart';

class QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final String routeName;
  final Object? arguments;
  final bool isGradient;

  const QuickActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
    required this.routeName,
    this.arguments,
    this.isGradient = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigationService.navigateTo(routeName, arguments: arguments);
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: isGradient
              ? LinearGradient(
                  colors: [
                    color.withOpacity(0.3),
                    color.withOpacity(0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isGradient ? null : color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    color.withOpacity(0.3),
                    color.withOpacity(0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Icon(
                icon,
                size: 32,
                color: color,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: color,
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}