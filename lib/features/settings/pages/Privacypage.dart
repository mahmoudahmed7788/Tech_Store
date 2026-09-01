import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

import 'package:tech_store/features/auth/pages/TwoFactorPage.dart';
import 'package:tech_store/features/settings/Widgets/Security/SecurityTitle.dart';
import 'package:tech_store/features/settings/pages/ActiveDevicesPage.dart';

class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});

  Future<void> _authenticateBiometric(
    BuildContext context,
  ) async {
    final LocalAuthentication auth =
        LocalAuthentication();

    try {
      final bool isSupported =
          await auth.isDeviceSupported();

      final bool canCheckBiometrics =
          await auth.canCheckBiometrics;

      if (!isSupported || !canCheckBiometrics) {
        if (!context.mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Biometric authentication is not available on this device.',
            ),
          ),
        );

        return;
      }

      final bool authenticated =
          await auth.authenticate(
        localizedReason:
            'Please authenticate to access your account security settings.',
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
                ? 'Biometric authentication successful.'
                : 'Biometric authentication failed.',
          ),
          backgroundColor: authenticated
              ? const Color(0xFF4C5DFF)
              : Colors.red,
        ),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Biometric authentication failed: $e',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

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
          'Privacy & Security',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SecurityTile(
            icon: Icons.fingerprint,
            title: 'Biometric Login',
            onTap: () {
              _authenticateBiometric(context);
            },
          ),

          SecurityTile(
            icon: Icons.verified_user_outlined,
            title: 'Two-Factor Authentication',
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

          SecurityTile(
            icon: Icons.devices_outlined,
            title: 'Active Devices',
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
    );
  }
}
