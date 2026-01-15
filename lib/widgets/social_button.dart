import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SocialButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String? tooltip;
  final double size;
  final Color? backgroundColor;

  const SocialButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.size = 56,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip ?? '',
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: backgroundColor ?? AppColors.surface,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
            gradient: backgroundColor == null ? AppColors.cardGradient : null,
          ),
          child: Icon(
            icon,
            color: AppColors.onSurface,
            size: size * 0.4,
          ),
        ),
      ),
    );
  }
}