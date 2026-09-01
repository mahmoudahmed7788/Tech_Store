import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tech_store/core/constsnts/AppStrings.dart';
import 'package:tech_store/features/settings/cubits/SettingsCubit.dart';

class ThemeDialog extends StatelessWidget {
  const ThemeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return AlertDialog(
          title: Text(
            AppStrings.appearance(context),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<ThemeMode>(
                title: Text(
                  AppStrings.darkMode(context),
                ),
                value: ThemeMode.dark,
                groupValue: state.themeMode,
                onChanged: (value) {
                  if (value == null) return;

                  context
                      .read<SettingsCubit>()
                      .setThemeMode(value);

                  Navigator.pop(context);
                },
              ),

              RadioListTile<ThemeMode>(
                title: Text(
                  AppStrings.lightMode(context),
                ),
                value: ThemeMode.light,
                groupValue: state.themeMode,
                onChanged: (value) {
                  if (value == null) return;

                  context
                      .read<SettingsCubit>()
                      .setThemeMode(value);

                  Navigator.pop(context);
                },
              ),

              RadioListTile<ThemeMode>(
                title: Text(
                  AppStrings.systemMode(context),
                ),
                value: ThemeMode.system,
                groupValue: state.themeMode,
                onChanged: (value) {
                  if (value == null) return;

                  context
                      .read<SettingsCubit>()
                      .setThemeMode(value);

                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
