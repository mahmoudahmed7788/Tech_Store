import 'package:flutter/material.dart';
import 'package:tech_store/features/settings/Widgets/Notfication/NotficationTitle.dart';


class NotificationsPage extends StatefulWidget {
  const NotificationsPage({
    super.key,
  });

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
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor:
          theme.scaffoldBackgroundColor,

      appBar: AppBar(
        backgroundColor:
            theme.scaffoldBackgroundColor,

        foregroundColor:
            theme.appBarTheme.foregroundColor ??
                theme.textTheme.bodyLarge?.color,

        elevation: 0,

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
          NotificationTile(
            title: 'Order Notifications',
            subtitle:
                'Get updates about your orders',
            value: orderNotifications,
            onChanged: (value) {
              setState(() {
                orderNotifications = value;
              });
            },
          ),

          NotificationTile(
            title: 'Offers & Promotions',
            subtitle:
                'Receive special offers and discounts',
            value: offersNotifications,
            onChanged: (value) {
              setState(() {
                offersNotifications = value;
              });
            },
          ),

          NotificationTile(
            title: 'System Notifications',
            subtitle:
                'Receive important app notifications',
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
}
