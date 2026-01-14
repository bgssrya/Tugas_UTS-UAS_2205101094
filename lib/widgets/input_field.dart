import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class InputField extends StatelessWidget {
  final String label;
  final bool obscure;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const InputField({
    super.key,
    required this.label,
    this.obscure = false,
    this.prefixIcon,
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        obscureText: obscure,
        style: const TextStyle(
          color: AppColors.onBackground,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  color: AppColors.accent.withOpacity(0.7),
                )
              : null,
          floatingLabelStyle: TextStyle(
            color: AppColors.accent,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          labelStyle: const TextStyle(
            color: AppColors.onSurface,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}