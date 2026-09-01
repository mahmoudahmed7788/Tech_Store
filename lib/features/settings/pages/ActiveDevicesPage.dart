import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:tech_store/core/constsnts/AppStrings.dart';
import 'package:tech_store/core/constsnts/DeviceService.dart';
import 'package:tech_store/features/settings/widgets/devices/DeviceCard.dart';

class ActiveDevicesPage extends StatelessWidget {
  const ActiveDevicesPage({super.key});

  static const Color primaryBlue =
      Color(0xFF4C5DFF);

  static String _deviceRemovedSuccessfully(
    BuildContext context,
  ) =>
      AppStrings.get(
        context,
        en: 'Device removed successfully',
        ar: 'تمت إزالة الجهاز بنجاح',
      );

  static String _couldNotRemoveDevice(
    BuildContext context,
  ) =>
      AppStrings.get(
        context,
        en: 'Could not remove device',
        ar: 'تعذرت إزالة الجهاز',
      );

  // =============================================================
  // REMOVE DEVICE
  // =============================================================

  Future<void> _removeDevice(
    BuildContext context,
    String deviceId,
  ) async {
    try {
      await DeviceService.removeDevice(
        deviceId,
      );

      if (!context.mounted) return;

      ScaffoldMessenger.of(context)
          .hideCurrentSnackBar();

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            _deviceRemovedSuccessfully(
              context,
            ),
          ),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context)
          .hideCurrentSnackBar();

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            _couldNotRemoveDevice(
              context,
            ),
          ),
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

    final user =
        FirebaseAuth.instance.currentUser;

    // ===========================================================
    // NO USER
    // ===========================================================

    if (user == null) {
      return Scaffold(
        backgroundColor:
            theme.scaffoldBackgroundColor,

        appBar: AppBar(
          backgroundColor:
              theme.scaffoldBackgroundColor,

          foregroundColor:
              theme.textTheme.titleLarge?.color,

          elevation: 0,

          title: Text(
            AppStrings.activeDevices(
              context,
            ),
            style: TextStyle(
              color: theme.textTheme
                  .titleLarge?.color,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ),

        body: Center(
          child: Text(
            AppStrings.noLoggedUser(
              context,
            ),
            style: TextStyle(
              color: theme.textTheme
                  .bodyLarge?.color,
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
      backgroundColor:
          theme.scaffoldBackgroundColor,

      appBar: AppBar(
        backgroundColor:
            theme.scaffoldBackgroundColor,

        foregroundColor:
            theme.textTheme.titleLarge?.color,

        elevation: 0,

        title: Text(
          AppStrings.activeDevices(
            context,
          ),
          style: TextStyle(
            color: theme.textTheme
                .titleLarge?.color,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body:
          StreamBuilder<
              QuerySnapshot<
                  Map<String, dynamic>>>(
        stream:
            DeviceService.getDevices(),

        builder: (
          context,
          snapshot,
        ) {
          // ======================================================
          // LOADING
          // ======================================================

          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child:
                  CircularProgressIndicator(
                color: primaryBlue,
              ),
            );
          }

          // ======================================================
          // ERROR
          // ======================================================

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding:
                    const EdgeInsets.all(20),

                child: Column(
                  mainAxisSize:
                      MainAxisSize.min,

                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 55,
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    Text(
                      AppStrings.error(
                        context,
                      ),
                      textAlign:
                          TextAlign.center,
                      style: TextStyle(
                        color: theme
                            .textTheme
                            .bodyLarge
                            ?.color,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    Text(
                      snapshot.error
                          .toString(),
                      textAlign:
                          TextAlign.center,
                      style: TextStyle(
                        color: theme
                            .textTheme
                            .bodyMedium
                            ?.color
                            ?.withOpacity(
                              0.65,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final devices =
              snapshot.data?.docs ?? [];

          // ======================================================
          // EMPTY
          // ======================================================

          if (devices.isEmpty) {
            return _emptyDevices(
              context,
            );
          }

          // ======================================================
          // DEVICES
          // ======================================================

          return ListView(
            padding:
                const EdgeInsets.all(20),

            children: [
              const SizedBox(
                height: 10,
              ),

              // ==================================================
              // ICON
              // ==================================================

              const Icon(
                Icons.devices_outlined,
                color: primaryBlue,
                size: 75,
              ),

              const SizedBox(
                height: 15,
              ),

              // ==================================================
              // TITLE
              // ==================================================

              Text(
                AppStrings.activeDevices(
                  context,
                ),

                textAlign:
                    TextAlign.center,

                style: TextStyle(
                  color: theme.textTheme
                      .headlineSmall
                      ?.color,

                  fontSize: 23,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 8,
              ),

              // ==================================================
              // COUNT
              // ==================================================

              Text(
                '${devices.length} ${AppStrings.activeDevices(context)}',

                textAlign:
                    TextAlign.center,

                style: TextStyle(
                  color: theme.textTheme
                      .bodyMedium
                      ?.color
                      ?.withOpacity(
                        0.65,
                      ),

                  fontSize: 14,
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              // ==================================================
              // DEVICE LIST
              // ==================================================

              ...devices.map(
                (device) {
                  final data =
                      device.data();

                  final String
                      deviceName =
                      data['deviceName'] ??
                          'Unknown';

                  final String
                      platform =
                      data['platform'] ??
                          'Unknown';

                  final String email =
                      data['email'] ??
                          user.email ??
                          '';

                  final bool current =
                      data['current'] ??
                          false;

                  return DeviceCard(
                    deviceName:
                        deviceName,

                    platform:
                        platform,

                    email:
                        email,

                    current:
                        current,

                    onDelete: () {
                      _showDeleteDialog(
                        context,
                        device.id,
                        deviceName,
                      );
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  // =============================================================
  // EMPTY DEVICES
  // =============================================================

  Widget _emptyDevices(
    BuildContext context,
  ) {
    final theme =
        Theme.of(context);

    return Center(
      child: Padding(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 30,
        ),

        child: Column(
          mainAxisSize:
              MainAxisSize.min,

          children: [
            const Icon(
              Icons.devices_other_outlined,
              color: primaryBlue,
              size: 75,
            ),

            const SizedBox(
              height: 20,
            ),

            Text(
              'No active devices',

              textAlign:
                  TextAlign.center,

              style: TextStyle(
                color: theme.textTheme
                    .bodyLarge?.color,

                fontSize: 18,

                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ],
        ),
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
    final theme =
        Theme.of(context);

    showDialog(
      context: context,

      builder:
          (dialogContext) {
        return AlertDialog(
          backgroundColor:
              theme.dialogBackgroundColor,

          title: Text(
            'Remove Device',

            style: TextStyle(
              color: theme.textTheme
                  .titleLarge?.color,

              fontWeight:
                  FontWeight.bold,
            ),
          ),

          content: Text(
            'Are you sure you want to remove $deviceName?',

            style: TextStyle(
              color: theme.textTheme
                  .bodyMedium?.color,
            ),
          ),

          actions: [
            // ==================================================
            // CANCEL
            // ==================================================

            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                );
              },

              child: Text(
                AppStrings.cancel(
                  context,
                ),
              ),
            ),

            // ==================================================
            // REMOVE
            // ==================================================

            TextButton(
              onPressed: () async {
                Navigator.pop(
                  dialogContext,
                );

                await _removeDevice(
                  context,
                  deviceId,
                );
              },

              child: Text(
                AppStrings.remove(
                  context,
                ),

                style:
                    const TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

