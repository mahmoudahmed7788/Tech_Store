import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_store/features/settings/Widgets/Language/LanguageTitle.dart';

import 'package:tech_store/features/settings/cubits/SettingsCubit.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
        SettingsCubit,
        SettingsState>(
      builder: (
        context,
        state,
      ) {
        final isArabic =
            state.locale.languageCode == 'ar';

        final theme =
            Theme.of(context);

        return Scaffold(
          backgroundColor:
              theme.scaffoldBackgroundColor,

          appBar: AppBar(
            backgroundColor:
                theme.scaffoldBackgroundColor,

            foregroundColor:
                theme.appBarTheme
                        .foregroundColor ??
                    theme.textTheme
                        .bodyLarge?.color,

            elevation: 0,

            title: Text(
              isArabic
                  ? 'اللغة'
                  : 'Language',

              style: const TextStyle(
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),

          body: ListView(
            padding:
                const EdgeInsets.all(20),

            children: [
              LanguageTile(
                title: 'English',
                selected: !isArabic,

                onTap: () {
                  context
                      .read<SettingsCubit>()
                      .setLanguage(
                        'English',
                      );
                },
              ),

              LanguageTile(
                title: 'العربية',
                selected: isArabic,

                onTap: () {
                  context
                      .read<SettingsCubit>()
                      .setLanguage(
                        'Arabic',
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
