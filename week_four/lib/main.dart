import 'package:flutter/material.dart';
import 'package:week_four/pages/login.dart';
import 'package:week_four/theme/theme.dart';
import 'package:week_four/theme/theme_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: appThemeModeNotifier,
      builder: (context, mode, child) {
        return MaterialApp(
          theme: lightmode,
          darkTheme: darkmode,
          themeMode: mode,
          debugShowCheckedModeBanner: false,
          home: const Login(),
        );
      },
    );
  }
}
