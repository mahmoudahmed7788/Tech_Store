import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:tech_store/core/constsnts/AppStrings.dart';
import 'package:tech_store/features/settings/cubits/SettingsCubit.dart';

class SettingsPage extends StatelessWidget {
  final String userName;

  const SettingsPage({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final theme = Theme.of(context);

        return SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const SizedBox(height: 20),

              // =====================================================
              // TITLE
              // =====================================================
              Text(
                AppStrings.settings(context),
                style: TextStyle(
                  color: theme.textTheme.headlineMedium?.color,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              // =====================================================
              // PROFILE
              // =====================================================
              _settingsTile(
                context,
                Icons.person_outline,
                AppStrings.profile(context),
                () {
                  context.push('/profile', extra: userName);
                },
              ),

              // =====================================================
              // NOTIFICATIONS
              // =====================================================
              _settingsTile(
                context,
                Icons.notifications_none,
                AppStrings.notifications(context),
                () {
                  context.push('/notifications');
                },
              ),

              // =====================================================
              // SECURITY
              // =====================================================
              _settingsTile(
                context,
                Icons.lock_outline,
                AppStrings.privacySecurity(context),
                () {
                  context.push('/security');
                },
              ),

              // =====================================================
              // LANGUAGE
              // =====================================================
              _settingsTile(
                context,
                Icons.language,
                AppStrings.language(context),
                () {
                  context.push('/language');
                },
              ),

              // =====================================================
              // PAYMENT METHODS
              // =====================================================
              _settingsTile(
                context,
                Icons.payment_outlined,
                AppStrings.payment(context),
                () {
                  context.push('/payment-methods');
                },
              ),

              // =====================================================
              // APPEARANCE
              // =====================================================
              _settingsTile(
                context,
                Icons.dark_mode_outlined,
                AppStrings.Appearance(context),
                () {
                  _showThemeDialog(context);
                },
              ),

              // =====================================================
              // HELP
              // =====================================================
              _settingsTile(
                context,
                Icons.help_outline,
                AppStrings.helpSupport(context),
                () {
                  context.push('/help');
                },
              ),

              // =====================================================
              // LOGOUT
              // =====================================================
              _settingsTile(
                context,
                Icons.logout,
                AppStrings.logout(context),
                () {
                  _showLogoutDialog(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // =============================================================
  // SETTINGS TILE
  // =============================================================

  Widget _settingsTile(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          leading: Icon(icon, color: theme.iconTheme.color),

          title: Text(
            title,
            style: TextStyle(
              color: theme.textTheme.bodyLarge?.color,
              fontSize: 15,
            ),
          ),

          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: theme.iconTheme.color?.withOpacity(0.5),
          ),

          onTap: onTap,
        ),
      ),
    );
  }

  // =============================================================
  // THEME DIALOG
  // =============================================================

  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return AlertDialog(
              title: Text(AppStrings.appearance(context)),

              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // DARK MODE
                  RadioListTile<ThemeMode>(
                    title: Text(AppStrings.darkMode(context)),
                    value: ThemeMode.dark,
                    groupValue: state.themeMode,
                    onChanged: (value) {
                      if (value == null) return;

                      context.read<SettingsCubit>().setThemeMode(value);

                      Navigator.pop(dialogContext);
                    },
                  ),

                  // LIGHT MODE
                  RadioListTile<ThemeMode>(
                    title: Text(AppStrings.lightMode(context)),
                    value: ThemeMode.light,
                    groupValue: state.themeMode,
                    onChanged: (value) {
                      if (value == null) return;

                      context.read<SettingsCubit>().setThemeMode(value);

                      Navigator.pop(dialogContext);
                    },
                  ),

                  // SYSTEM
                  RadioListTile<ThemeMode>(
                    title: Text(AppStrings.systemMode(context)),
                    value: ThemeMode.system,
                    groupValue: state.themeMode,
                    onChanged: (value) {
                      if (value == null) return;

                      context.read<SettingsCubit>().setThemeMode(value);

                      Navigator.pop(dialogContext);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // =============================================================
  // LOGOUT DIALOG
  // =============================================================

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(AppStrings.logout(context)),

          content: Text(AppStrings.logoutQuestion(context)),

          actions: [
            // CANCEL
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: Text(AppStrings.cancel(context)),
            ),

            // LOGOUT
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                context.go('/login');
              },
              child: Text(
                AppStrings.logout(context),
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
