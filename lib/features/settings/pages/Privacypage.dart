import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:tech_store/features/auth/pages/TwoFactorPage.dart';
import 'package:tech_store/features/settings/pages/ActiveDevicesPage.dart';

class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});

  Future<void> _authenticateBiometric(BuildContext context) async {
    final LocalAuthentication auth = LocalAuthentication();

    try {
      final bool isSupported = await auth.isDeviceSupported();
      final bool canCheckBiometrics = await auth.canCheckBiometrics;

      if (!isSupported || !canCheckBiometrics) {
        if (!context.mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Biometric authentication is not available on this device.',
            ),
            backgroundColor: Colors.red,
          ),
        );

        return;
      }

      final bool authenticated = await auth.authenticate(
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
          backgroundColor:
              authenticated
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
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
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

          // ================= BIOMETRIC =================

          _securityTile(
            icon: Icons.fingerprint,
            title: 'Biometric Login',
            onTap: () {
              _authenticateBiometric(context);
            },
          ),

          // ================= 2FA =================

          _securityTile(
            icon: Icons.verified_user_outlined,
            title: 'Two-Factor Authentication',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const TwoFactorPage(),
                ),
              );
            },
          ),

          // ================= ACTIVE DEVICES =================

          _securityTile(
            icon: Icons.devices_outlined,
            title: 'Active Devices',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ActiveDevicesPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SECURITY TILE
  // ============================================================

  Widget _securityTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 17,
            ),
            child: Row(
              children: [

                Icon(
                  icon,
                  color: Colors.white,
                  size: 26,
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
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