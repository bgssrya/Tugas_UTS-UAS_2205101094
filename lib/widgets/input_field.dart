import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class InputField extends StatelessWidget {
  final String label;
  final bool obscure;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final bool enabled;
  final String? hintText;

  const InputField({
    super.key,
    required this.label,
    this.obscure = false,
    this.prefixIcon,
    this.controller,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.enabled = true,
    this.hintText,
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
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        obscureText: obscure,
        validator: validator,
        keyboardType: keyboardType,
        enabled: enabled,
        style: const TextStyle(
          color: AppColors.onBackground,
          fontSize: 16,
          fontFamily: 'Poppins',
        ),
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  color: AppColors.accent.withOpacity(0.7),
                )
              : null,
          suffixIcon: obscure
              ? IconButton(
                  icon: Icon(
                    obscure ? Icons.visibility : Icons.visibility_off,
                    color: AppColors.onSurface.withOpacity(0.5),
                  ),
                  onPressed: () {},
                )
              : null,
          floatingLabelStyle: const TextStyle(
            color: AppColors.accent,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
          labelStyle: const TextStyle(
            color: AppColors.onSurface,
            fontSize: 14,
            fontFamily: 'Poppins',
          ),
          hintStyle: TextStyle(
            color: AppColors.onSurface.withOpacity(0.5),
            fontSize: 14,
          ),
          errorStyle: const TextStyle(
            color: AppColors.error,
            fontSize: 12,
          ),
          filled: true,
          fillColor: Colors.transparent,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
        ),
      ),
    );
  }
}