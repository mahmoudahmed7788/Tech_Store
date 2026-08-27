import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

import 'package:tech_store/core/constsnts/AppStrings.dart';
import 'package:tech_store/features/auth/pages/TwoFactorPage.dart';
import 'package:tech_store/features/settings/pages/ActiveDevicesPage.dart';

class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});

  static const Color primaryBlue = Color(0xFF4C5DFF);

  // ============================================================
  // BIOMETRIC AUTHENTICATION
  // ============================================================

  Future<void> _authenticateBiometric(
    BuildContext context,
  ) async {
    final LocalAuthentication auth = LocalAuthentication();

    try {
      final bool isSupported =
          await auth.isDeviceSupported();

      final bool canCheckBiometrics =
          await auth.canCheckBiometrics;

      if (!isSupported || !canCheckBiometrics) {
        if (!context.mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppStrings.biometricUnavailable(context),
            ),
            backgroundColor: Colors.red,
          ),
        );

        return;
      }

      final bool authenticated =
          await auth.authenticate(
        localizedReason:
            AppStrings.biometricLogin(context),
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            authenticated
                ? AppStrings.biometricAvailable(context)
                : AppStrings.get(
                    context,
                    en: 'Biometric authentication failed.',
                    ar: 'فشلت المصادقة بالبصمة.',
                  ),
          ),
          backgroundColor:
              authenticated ? primaryBlue : Colors.red,
        ),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppStrings.get(
              context,
              en: 'Biometric authentication failed.',
              ar: 'فشلت المصادقة بالبصمة.',
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // ============================================================
  // BUILD
  // ============================================================

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
            theme.textTheme.titleLarge?.color,

        elevation: 0,

        title: Text(
          AppStrings.privacySecurity(context),
          style: TextStyle(
            color:
                theme.textTheme.titleLarge?.color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),

          children: [
            // ==================================================
            // BIOMETRIC
            // ==================================================

            _securityTile(
              context: context,
              icon: Icons.fingerprint,
              title:
                  AppStrings.biometricLogin(context),
              onTap: () {
                _authenticateBiometric(context);
              },
            ),

            // ==================================================
            // TWO FACTOR
            // ==================================================

            _securityTile(
              context: context,
              icon:
                  Icons.verified_user_outlined,
              title:
                  AppStrings.twoFactor(context),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const TwoFactorPage(),
                  ),
                );
              },
            ),

            // ==================================================
            // ACTIVE DEVICES
            // ==================================================

            _securityTile(
              context: context,
              icon:
                  Icons.devices_outlined,
              title:
                  AppStrings.activeDevices(context),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const ActiveDevicesPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECURITY TILE
  // ============================================================

  Widget _securityTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    final Color iconColor =
        theme.iconTheme.color ??
            theme.colorScheme.onSurface;

    final Color textColor =
        theme.textTheme.bodyLarge?.color ??
            theme.colorScheme.onSurface;

    final Color arrowColor =
        theme.iconTheme.color
                ?.withOpacity(0.5) ??
            theme.colorScheme.onSurface
                .withOpacity(0.5);

    return Container(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),

      decoration: BoxDecoration(
        color: theme.cardColor,

        borderRadius:
            BorderRadius.circular(16),

        border: Border.all(
          color: theme.dividerColor,
        ),
      ),

      child: Material(
        color: Colors.transparent,

        borderRadius:
            BorderRadius.circular(16),

        clipBehavior:
            Clip.antiAlias,

        child: InkWell(
          onTap: onTap,

          borderRadius:
              BorderRadius.circular(16),

          child: Padding(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 17,
            ),

            child: Row(
              children: [
                // =================================================
                // ICON
                // =================================================

                Icon(
                  icon,
                  color: iconColor,
                  size: 26,
                ),

                const SizedBox(
                  width: 16,
                ),

                // =================================================
                // TITLE
                // =================================================

                Expanded(
                  child: Text(
                    title,

                    style: TextStyle(
                      color: textColor,
                      fontSize: 15,
                      fontWeight:
                          FontWeight.w500,
                    ),
                  ),
                ),

                // =================================================
                // ARROW
                // =================================================

                Icon(
                  Icons.arrow_forward_ios,
                  color: arrowColor,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
