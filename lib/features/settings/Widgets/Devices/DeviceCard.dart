import 'package:flutter/material.dart';

class DeviceCard extends StatelessWidget {
  final String deviceName;
  final String platform;
  final String email;
  final bool current;
  final VoidCallback onDelete;

  const DeviceCard({
    super.key,
    required this.deviceName,
    required this.platform,
    required this.email,
    required this.current,
    required this.onDelete,
  });

  static const primaryBlue = Color(0xFF4C5DFF);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: primaryBlue.withOpacity(.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              platform == 'Android'
                  ? Icons.phone_android
                  : Icons.devices,
              color: primaryBlue,
              size: 30,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  deviceName,
                  style: TextStyle(
                    color: theme.textTheme.bodyLarge?.color,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(platform),

                const SizedBox(height: 3),

                Text(
                  email,
                  maxLines: 1,
                  overflow:
                      TextOverflow.ellipsis,
                ),

                const SizedBox(height: 7),

                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      size: 9,
                      color: current
                          ? Colors.green
                          : Colors.grey,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      current
                          ? 'Current Device'
                          : 'Active Device',
                      style: TextStyle(
                        color: current
                            ? Colors.green
                            : Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: onDelete,
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
