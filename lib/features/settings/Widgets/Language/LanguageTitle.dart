import 'package:flutter/material.dart';

class LanguageTile extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const LanguageTile({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  static const Color primaryBlue =
      Color(0xFF4C5DFF);

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
            BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius:
            BorderRadius.circular(16),
        child: InkWell(
          borderRadius:
              BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            child: Row(
              children: [
                Icon(
                  selected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  color: selected
                      ? primaryBlue
                      : theme.iconTheme.color,
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: theme.textTheme
                          .bodyLarge?.color,
                      fontSize: 16,
                      fontWeight: selected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
