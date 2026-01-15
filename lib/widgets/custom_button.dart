import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool hasGradient;
  final IconData? icon;
  final bool isLoading;
  final double? width;
  final double height;
  final Color? textColor;
  final Color? backgroundColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.hasGradient = true,
    this.icon,
    this.isLoading = false,
    this.width,
    this.height = 56,
    this.textColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
          gradient: hasGradient
              ? AppColors.buttonGradient
              : backgroundColor != null
                  ? LinearGradient(
                      colors: [backgroundColor!, backgroundColor!],
                    )
                  : LinearGradient(
                      colors: [
                        AppColors.surface.withOpacity(0.8),
                        AppColors.surface,
                      ],
                    ),
        ),
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: textColor ?? AppColors.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
            disabledBackgroundColor: AppColors.surface.withOpacity(0.5),
            disabledForegroundColor: AppColors.onSurface,
          ),
          child: isLoading
              ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: AppColors.onPrimary,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[
                      Icon(
                        icon,
                        size: 22,
                      ),
                      const SizedBox(width: 12),
                    ],
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                        color: textColor ?? AppColors.onPrimary,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}