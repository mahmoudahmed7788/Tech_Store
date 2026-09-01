import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:tech_store/core/constsnts/AppStrings.dart';
import 'package:tech_store/features/settings/Widgets/SettingsTittle.dart';
import 'package:tech_store/features/settings/cubits/SettingsCubit.dart';
import 'package:tech_store/features/settings/widgets/ThemeDialog.dart';
import 'package:tech_store/features/settings/widgets/LogoutDialog.dart';

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

              Text(
                AppStrings.settings(context),
                style: TextStyle(
                  color: theme.textTheme.headlineMedium?.color,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              SettingsTile(
                icon: Icons.person_outline,
                title: AppStrings.profile(context),
                onTap: () {
                  context.push('/profile', extra: userName);
                },
              ),

              SettingsTile(
                icon: Icons.notifications_none,
                title: AppStrings.notifications(context),
                onTap: () {
                  context.push('/notifications');
                },
              ),

              SettingsTile(
                icon: Icons.lock_outline,
                title: AppStrings.privacySecurity(context),
                onTap: () {
                  context.push('/security');
                },
              ),

              SettingsTile(
                icon: Icons.language,
                title: AppStrings.language(context),
                onTap: () {
                  context.push('/language');
                },
              ),

              SettingsTile(
                icon: Icons.payment_outlined,
                title: AppStrings.paymentMethods(context),
                onTap: () {
                  context.push('/payment-methods');
                },
              ),

              SettingsTile(
                icon: Icons.dark_mode_outlined,
                title: AppStrings.appearance(context),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return const ThemeDialog();
                    },
                  );
                },
              ),

              SettingsTile(
                icon: Icons.help_outline,
                title: AppStrings.helpSupport(context),
                onTap: () {
                  context.push('/help');
                },
              ),

              SettingsTile(
                icon: Icons.logout,
                title: AppStrings.logout(context),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return const LogoutDialog();
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
