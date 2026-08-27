import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            state.locale.languageCode ==
                'ar';

        final theme =
            Theme.of(context);

        return Scaffold(
          backgroundColor:
              theme.scaffoldBackgroundColor,

          appBar: AppBar(
            title: Text(
              isArabic
                  ? 'اللغة'
                  : 'Language',

              style:
                  const TextStyle(
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),

          body: ListView(
            padding:
                const EdgeInsets.all(
              20,
            ),

            children: [
              _languageTile(
                context,
                title: 'English',
                value: 'English',
                selected:
                    !isArabic,
              ),

              _languageTile(
                context,
                title: 'العربية',
                value: 'Arabic',
                selected:
                    isArabic,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _languageTile(
    BuildContext context, {
    required String title,
    required String value,
    required bool selected,
  }) {
    final theme =
        Theme.of(context);

    return Container(
      margin:
          const EdgeInsets.only(
        bottom: 12,
      ),

      decoration:
          BoxDecoration(
        color:
            theme.cardColor,

        borderRadius:
            BorderRadius.circular(
          16,
        ),
      ),

      child: InkWell(
        borderRadius:
            BorderRadius.circular(
          16,
        ),

        onTap: () {
          context
              .read<SettingsCubit>()
              .setLanguage(
                value,
              );
        },

        child: Padding(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 6,
          ),

          child: Row(
            children: [
              Icon(
                selected
                    ? Icons
                        .radio_button_checked
                    : Icons
                        .radio_button_off,

                color: selected
                    ? const Color(
                        0xFF4C5DFF,
                      )
                    : theme
                        .iconTheme
                        .color,
              ),

              const SizedBox(
                width: 14,
              ),

              Expanded(
                child: Text(
                  title,

                  style: TextStyle(
                    color: theme
                        .textTheme
                        .bodyLarge
                        ?.color,

                    fontSize: 16,

                    fontWeight:
                        selected
                            ? FontWeight.w600
                            : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
