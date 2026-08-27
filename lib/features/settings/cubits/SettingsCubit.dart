import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsState {
  final ThemeMode themeMode;
  final Locale locale;

  const SettingsState({
    this.themeMode = ThemeMode.dark,
    this.locale = const Locale('en'),
  });

  SettingsState copyWith({
    ThemeMode? themeMode,
    Locale? locale,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
    );
  }
}

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
      : super(
          const SettingsState(),
        );

  // =========================================================
  // THEME
  // =========================================================

  void setThemeMode(ThemeMode mode) {
    emit(
      state.copyWith(
        themeMode: mode,
      ),
    );
  }

  // =========================================================
  // LANGUAGE
  // =========================================================

  void setLanguage(String language) {
    if (language == 'Arabic') {
      emit(
        state.copyWith(
          locale: const Locale('ar'),
        ),
      );
    } else {
      emit(
        state.copyWith(
          locale: const Locale('en'),
        ),
      );
    }
  }
}