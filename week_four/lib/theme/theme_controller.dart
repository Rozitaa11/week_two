import 'package:flutter/material.dart';

final ValueNotifier<ThemeMode> appThemeModeNotifier = ValueNotifier(
  ThemeMode.light,
);

void toggleAppThemeMode() {
  appThemeModeNotifier.value = appThemeModeNotifier.value == ThemeMode.light
      ? ThemeMode.dark
      : ThemeMode.light;
}
