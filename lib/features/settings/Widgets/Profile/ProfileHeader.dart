import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String userName;

  const ProfileHeader({
    super.key,
    required this.userName,
  });

  static const Color primaryBlue =
      Color(0xFF4C5DFF);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textColor =
        theme.textTheme.bodyLarge?.color ??
            Colors.white;

    return Column(
      children: [
        const SizedBox(height: 20),

        const CircleAvatar(
          radius: 55,
          backgroundColor: primaryBlue,
          child: Icon(
            Icons.person,
            color: Colors.white,
            size: 60,
          ),
        ),

        const SizedBox(height: 20),

        Text(
          userName.isEmpty ? 'User' : userName,
          style: TextStyle(
            color: textColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 35),
      ],
    );
  }
}