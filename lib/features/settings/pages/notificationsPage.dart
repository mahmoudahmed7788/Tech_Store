import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() =>
      _NotificationsPageState();
}

class _NotificationsPageState
    extends State<NotificationsPage> {

  bool orderNotifications = true;
  bool offersNotifications = true;
  bool systemNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,

        title: const Text(
          'Notifications',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),

        children: [

          _notificationTile(
            title: 'Order Notifications',
            subtitle: 'Get updates about your orders',
            value: orderNotifications,

            onChanged: (value) {
              setState(() {
                orderNotifications = value;
              });
            },
          ),

          _notificationTile(
            title: 'Offers & Promotions',
            subtitle: 'Receive special offers and discounts',
            value: offersNotifications,

            onChanged: (value) {
              setState(() {
                offersNotifications = value;
              });
            },
          ),

          _notificationTile(
            title: 'System Notifications',
            subtitle: 'Receive important app notifications',
            value: systemNotifications,

            onChanged: (value) {
              setState(() {
                systemNotifications = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _notificationTile({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),

      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(14),
      ),

      child: SwitchListTile(
        activeThumbColor:
            const Color(0xFF4C5DFF),

        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),

        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),

        value: value,
        onChanged: onChanged,
      ),
    );
  }
}