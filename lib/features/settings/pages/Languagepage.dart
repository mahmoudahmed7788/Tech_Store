import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tech_store/core/constsnts/AppStrings.dart';
import 'package:tech_store/features/settings/cubits/SettingsCubit.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({
    super.key,
  });

  static const Color primaryBlue = Color(0xFF4C5DFF);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final theme = Theme.of(context);

        final bool isArabic =
            state.locale.languageCode == 'ar';

        return Scaffold(
          backgroundColor:
              theme.scaffoldBackgroundColor,

          appBar: AppBar(
            backgroundColor:
                theme.scaffoldBackgroundColor,

            elevation: 0,

            iconTheme: IconThemeData(
              color: theme.iconTheme.color,
            ),

            title: Text(
              AppStrings.language(context),
              style: TextStyle(
                color:
                    theme.textTheme.titleLarge?.color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          body: ListView(
            padding: const EdgeInsets.all(20),

            children: [
              // =====================================================
              // ENGLISH
              // =====================================================

              _languageTile(
                context,
                title: AppStrings.english(context),
                selected: !isArabic,
                onTap: () {
                  context
                      .read<SettingsCubit>()
                      .setLanguage('English');
                },
              ),

              // =====================================================
              // ARABIC
              // =====================================================

              _languageTile(
                context,
                title: AppStrings.arabic(context),
                selected: isArabic,
                onTap: () {
                  context
                      .read<SettingsCubit>()
                      .setLanguage('Arabic');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // =============================================================
  // LANGUAGE TILE
  // =============================================================

  Widget _languageTile(
    BuildContext context, {
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),

      decoration: BoxDecoration(
        color: theme.cardColor,

        borderRadius:
            BorderRadius.circular(16),
      ),

      child: Material(
        color: Colors.transparent,

        child: InkWell(
          borderRadius:
              BorderRadius.circular(16),

          onTap: onTap,

          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),

            child: Row(
              children: [
                Icon(
                  selected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,

                  color: selected
                      ? primaryBlue
                      : theme.iconTheme.color,
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Text(
                    title,

                    style: TextStyle(
                      color: theme
                          .textTheme
                          .bodyLarge
                          ?.color,

                      fontSize: 16,

                      fontWeight: selected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ),

                if (selected)
                  const Icon(
                    Icons.check,
                    color: primaryBlue,
                    size: 20,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}