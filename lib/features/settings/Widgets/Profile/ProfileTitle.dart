import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback onTap;

  const ProfileTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius:
            BorderRadius.circular(14),
      ),
      child: ListTile(
        onTap: onTap,

        leading: Icon(
          icon,
          color: theme.iconTheme.color,
        ),

        title: Text(
          title,
          style: TextStyle(
            color:
                theme.textTheme.bodySmall?.color,
            fontSize: 12,
          ),
        ),

        subtitle: Text(
          value,
          style: TextStyle(
            color:
                theme.textTheme.bodyLarge?.color,
            fontSize: 15,
          ),
        ),

        trailing: Icon(
          Icons.arrow_forward_ios,
          color: theme.iconTheme.color
              ?.withOpacity(0.5),
          size: 17,
        ),
      ),
    );
  }
}