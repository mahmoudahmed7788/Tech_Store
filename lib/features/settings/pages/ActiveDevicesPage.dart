import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:tech_store/core/constsnts/AppStrings.dart';
import 'package:tech_store/core/constsnts/DeviceService.dart';

class ActiveDevicesPage extends StatelessWidget {
  const ActiveDevicesPage({super.key});

  static const Color primaryBlue = Color(0xFF4C5DFF);

  static String _deviceRemovedSuccessfully(BuildContext context) =>
      AppStrings.get(
        context,
        en: 'Device removed successfully',
        ar: 'تمت إزالة الجهاز بنجاح',
      );

  static String _couldNotRemoveDevice(BuildContext context) => AppStrings.get(
    context,
    en: 'Could not remove device',
    ar: 'تعذرت إزالة الجهاز',
  );

  // =============================================================
  // REMOVE DEVICE
  // =============================================================

  Future<void> _removeDevice(BuildContext context, String deviceId) async {
    try {
      await DeviceService.removeDevice(deviceId);

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_deviceRemovedSuccessfully(context)),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_couldNotRemoveDevice(context)),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // =============================================================
  // BUILD
  // =============================================================

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final user = FirebaseAuth.instance.currentUser;

    // ===========================================================
    // NO USER
    // ===========================================================

    if (user == null) {
      return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,

        appBar: AppBar(
          backgroundColor: theme.scaffoldBackgroundColor,

          foregroundColor: theme.textTheme.titleLarge?.color,

          elevation: 0,

          title: Text(
            AppStrings.activeDevices(context),

            style: TextStyle(
              color: theme.textTheme.titleLarge?.color,

              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        body: Center(
          child: Text(
            AppStrings.noLoggedUser(context),

            style: TextStyle(
              color: theme.textTheme.bodyLarge?.color,

              fontSize: 16,
            ),
          ),
        ),
      );
    }

    // ===========================================================
    // MAIN PAGE
    // ===========================================================

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,

        foregroundColor: theme.textTheme.titleLarge?.color,

        elevation: 0,

        title: Text(
          AppStrings.activeDevices(context),

          style: TextStyle(
            color: theme.textTheme.titleLarge?.color,

            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: DeviceService.getDevices(),

        builder: (context, snapshot) {
          // ======================================================
          // LOADING
          // ======================================================

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: primaryBlue),
            );
          }

          // ======================================================
          // ERROR
          // ======================================================

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 55,
                    ),

                    const SizedBox(height: 15),

                    Text(
                      AppStrings.error(context),

                      textAlign: TextAlign.center,

                      style: TextStyle(
                        color: theme.textTheme.bodyLarge?.color,

                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      snapshot.error.toString(),

                      textAlign: TextAlign.center,

                      style: TextStyle(
                        color: theme.textTheme.bodyMedium?.color?.withOpacity(
                          0.65,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final devices = snapshot.data?.docs ?? [];

          final String devicesCountText =
              '${devices.length} ${devices.length == 1 ? AppStrings.activeDevices(context) : AppStrings.activeDevices(context)}';

          // ======================================================
          // EMPTY
          // ======================================================

          if (devices.isEmpty) {
            return _emptyDevices(context);
          }

          // ======================================================
          // DEVICES
          // ======================================================

          return ListView(
            padding: const EdgeInsets.all(20),

            children: [
              const SizedBox(height: 10),

              // ==================================================
              // ICON
              // ==================================================
              const Icon(Icons.devices_outlined, color: primaryBlue, size: 75),

              const SizedBox(height: 15),

              // ==================================================
              // TITLE
              // ==================================================
              Text(
                AppStrings.activeDevices(context),

                textAlign: TextAlign.center,

                style: TextStyle(
                  color: theme.textTheme.headlineSmall?.color,

                  fontSize: 23,

                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              // ==================================================
              // COUNT
              // ==================================================
              Text(
                '${devices.length} ${AppStrings.activeDevices(context)}',

                textAlign: TextAlign.center,

                style: TextStyle(
                  color: theme.textTheme.bodyMedium?.color?.withOpacity(0.65),

                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 30),

              // ==================================================
              // DEVICE LIST
              // ==================================================
              ...devices.map((device) {
                final data = device.data();

                final String deviceName = data['deviceName'] ?? 'Unknown';

                final String platform = data['platform'] ?? 'Unknown';

                final String email = data['email'] ?? user.email ?? '';

                final bool current = data['current'] ?? false;

                return _deviceCard(
                  context,

                  deviceId: device.id,

                  deviceName: deviceName,

                  platform: platform,

                  email: email,

                  current: current,
                );
              }),
            ],
          );
        },
      ),
    );
  }

  // =============================================================
  // EMPTY DEVICES
  // =============================================================

  Widget _emptyDevices(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),

        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            Icon(Icons.devices_other_outlined, color: primaryBlue, size: 75),

            const SizedBox(height: 20),

            Text(
              'No active devices',

              textAlign: TextAlign.center,

              style: TextStyle(
                color: theme.textTheme.bodyLarge?.color,

                fontSize: 18,

                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =============================================================
  // DEVICE CARD
  // =============================================================

  Widget _deviceCard(
    BuildContext context, {
    required String deviceId,
    required String deviceName,
    required String platform,
    required String email,
    required bool current,
  }) {
    final theme = Theme.of(context);

    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;

    final secondaryColor =
        theme.textTheme.bodyMedium?.color?.withOpacity(0.65) ?? Colors.grey;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: theme.cardColor,

        borderRadius: BorderRadius.circular(16),

        border: Border.all(color: theme.dividerColor),
      ),

      child: Row(
        children: [
          // =====================================================
          // DEVICE ICON
          // =====================================================
          Container(
            width: 55,
            height: 55,

            decoration: BoxDecoration(
              color: primaryBlue.withOpacity(0.15),

              borderRadius: BorderRadius.circular(14),
            ),

            child: Icon(
              platform.toLowerCase() == 'android'
                  ? Icons.phone_android
                  : Icons.devices,

              color: primaryBlue,

              size: 30,
            ),
          ),

          const SizedBox(width: 14),

          // =====================================================
          // DEVICE INFO
          // =====================================================
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                // DEVICE NAME
                Text(
                  deviceName,

                  maxLines: 1,

                  overflow: TextOverflow.ellipsis,

                  style: TextStyle(
                    color: textColor,

                    fontSize: 16,

                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                // PLATFORM
                Text(
                  platform,

                  style: TextStyle(color: secondaryColor, fontSize: 13),
                ),

                const SizedBox(height: 3),

                // EMAIL
                Text(
                  email,

                  maxLines: 1,

                  overflow: TextOverflow.ellipsis,

                  style: TextStyle(color: secondaryColor, fontSize: 12),
                ),

                const SizedBox(height: 7),

                // STATUS
                Row(
                  children: [
                    Icon(
                      Icons.circle,

                      size: 9,

                      color: current ? Colors.green : Colors.grey,
                    ),

                    const SizedBox(width: 6),

                    Text(
                      AppStrings.activeDevices(context),

                      style: TextStyle(
                        color: current ? Colors.green : secondaryColor,

                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // =====================================================
          // DELETE
          // =====================================================
          IconButton(
            onPressed: () {
              _showDeleteDialog(context, deviceId, deviceName);
            },

            icon: const Icon(Icons.delete_outline, color: Colors.red),
          ),
        ],
      ),
    );
  }

  // =============================================================
  // DELETE DIALOG
  // =============================================================

  void _showDeleteDialog(
    BuildContext context,
    String deviceId,
    String deviceName,
  ) {
    final theme = Theme.of(context);

    showDialog(
      context: context,

      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: theme.dialogBackgroundColor,

          title: Text(
            'Remove Device',

            style: TextStyle(
              color: theme.textTheme.titleLarge?.color,

              fontWeight: FontWeight.bold,
            ),
          ),

          content: Text(
            'Are you sure you want to remove $deviceName?',

            style: TextStyle(color: theme.textTheme.bodyMedium?.color),
          ),

          actions: [
            // ==================================================
            // CANCEL
            // ==================================================
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },

              child: Text(AppStrings.cancel(context)),
            ),

            // ==================================================
            // REMOVE
            // ==================================================
            TextButton(
              onPressed: () async {
                Navigator.pop(dialogContext);

                await _removeDevice(context, deviceId);
              },

              child: Text(
                AppStrings.remove(context),

                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
