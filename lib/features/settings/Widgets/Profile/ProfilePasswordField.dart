import 'package:flutter/material.dart';

class ProfilePasswordField
    extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscure;
  final VoidCallback onEyePressed;

  const ProfilePasswordField({
    super.key,
    required this.controller,
    required this.label,
    required this.obscure,
    required this.onEyePressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,

      decoration: InputDecoration(
        labelText: label,

        prefixIcon: const Icon(
          Icons.lock_outline,
        ),

        suffixIcon: IconButton(
          onPressed: onEyePressed,
          icon: Icon(
            obscure
                ? Icons.visibility
                : Icons.visibility_off,
          ),
        ),
      ),
    );
  }
}