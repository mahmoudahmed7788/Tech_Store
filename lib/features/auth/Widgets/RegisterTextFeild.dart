import 'package:flutter/material.dart';

class RegisterTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final TextInputType keyboardType;

  const RegisterTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    this.keyboardType = TextInputType.text, required IconButton suffixIcon, required bool obscureText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,

      style: TextStyle(
        color: theme.textTheme.bodyLarge?.color,
      ),

      decoration: InputDecoration(
        hintText: hint,

        hintStyle: TextStyle(
          color: theme.textTheme.bodyMedium?.color
              ?.withOpacity(.65),
        ),

        prefixIcon: Icon(
          icon,
          color: theme.iconTheme.color,
        ),

        filled: true,
        fillColor: theme.cardColor,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: theme.dividerColor,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Color(0xFF4C5DFF),
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
