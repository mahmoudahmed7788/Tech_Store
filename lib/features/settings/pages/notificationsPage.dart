import 'package:flutter/material.dart';
import 'package:tech_store/core/constsnts/AppStrings.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() =>
      _NotificationsPageState();
}

class _NotificationsPageState
    extends State<NotificationsPage> {
  static const Color primaryBlue =
      Color(0xFF4C5DFF);

  bool orderNotifications = true;
  bool offersNotifications = true;
  bool systemNotifications = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textColor =
        theme.textTheme.bodyLarge?.color ??
            Colors.white;

    final secondaryColor =
        theme.textTheme.bodyMedium?.color
                ?.withOpacity(0.65) ??
            Colors.grey;

    return Scaffold(
      backgroundColor:
          theme.scaffoldBackgroundColor,

      appBar: AppBar(
        backgroundColor:
            theme.scaffoldBackgroundColor,

        foregroundColor:
            textColor,

        elevation: 0,

        title: Text(
          AppStrings.notifications(context),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),

          children: [
            _notificationTile(
              context: context,
              icon: Icons.local_shipping_outlined,
              title: AppStrings.get(
                context,
                en: 'Order Notifications',
                ar: 'إشعارات الطلبات',
              ),
              subtitle: AppStrings.get(
                context,
                en: 'Get updates about your orders',
                ar: 'احصل على تحديثات حول طلباتك',
              ),
              value: orderNotifications,
              onChanged: (value) {
                setState(() {
                  orderNotifications = value;
                });
              },
            ),

            _notificationTile(
              context: context,
              icon: Icons.local_offer_outlined,
              title: AppStrings.get(
                context,
                en: 'Offers & Promotions',
                ar: 'العروض والتخفيضات',
              ),
              subtitle: AppStrings.get(
                context,
                en: 'Receive special offers and discounts',
                ar: 'استقبل العروض والخصومات الخاصة',
              ),
              value: offersNotifications,
              onChanged: (value) {
                setState(() {
                  offersNotifications = value;
                });
              },
            ),

            _notificationTile(
              context: context,
              icon: Icons.notifications_active_outlined,
              title: AppStrings.get(
                context,
                en: 'System Notifications',
                ar: 'إشعارات النظام',
              ),
              subtitle: AppStrings.get(
                context,
                en: 'Receive important app notifications',
                ar: 'استقبل إشعارات التطبيق المهمة',
              ),
              value: systemNotifications,
              onChanged: (value) {
                setState(() {
                  systemNotifications = value;
                });
              },
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius:
                    BorderRadius.circular(16),
              ),
              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: primaryBlue,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      AppStrings.get(
                        context,
                        en: 'You can control which notifications you want to receive.',
                        ar: 'يمكنك التحكم في الإشعارات التي تريد استقبالها.',
                      ),
                      style: TextStyle(
                        color: secondaryColor,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _notificationTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    final theme = Theme.of(context);

    final textColor =
        theme.textTheme.bodyLarge?.color ??
            Colors.white;

    final secondaryColor =
        theme.textTheme.bodyMedium?.color
                ?.withOpacity(0.65) ??
            Colors.grey;

    return Container(
      margin:
          const EdgeInsets.only(bottom: 12),

      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius:
            BorderRadius.circular(16),
      ),

      child: SwitchListTile(
        contentPadding:
            const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 5,
        ),

        secondary: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color:
                primaryBlue.withOpacity(0.12),
            borderRadius:
                BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: primaryBlue,
          ),
        ),

        title: Text(
          title,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        ),

        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: secondaryColor,
            fontSize: 12,
          ),
        ),

        activeThumbColor:
            primaryBlue,

        activeTrackColor:
            primaryBlue.withOpacity(0.35),

        value: value,

        onChanged: onChanged,
      ),
    );
  }
}
