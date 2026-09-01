import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const LoginTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
    this.validator,
  });

  static const primaryBlue = Color(0xFF4C5DFF);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,

      style: TextStyle(
        color: theme.textTheme.bodyLarge?.color,
      ),

      decoration: InputDecoration(
        hintText: hint,

        prefixIcon: Icon(
          icon,
          color: theme.iconTheme.color,
        ),

        suffixIcon: suffixIcon,

        filled: true,
        fillColor: theme.cardColor,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: primaryBlue,
            width: 2,
          ),
        ),
      ),
    );
  }
}
