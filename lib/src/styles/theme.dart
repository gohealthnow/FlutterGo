import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PreferencesTheme {
  static ValueNotifier<Brightness> themeMode = ValueNotifier(Brightness.light);

  static setTheme() {
    themeMode.value =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    changeStatusNavigationBar();
  }

  static changeStatusNavigationBar() {
    bool isDark = themeMode.value == Brightness.dark;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      statusBarBrightness: isDark ? Brightness.light : Brightness.dark,
      statusBarColor:
          isDark ? const Color(0xFF424242) : const Color(0xFF005BE2),
      systemNavigationBarIconBrightness:
          isDark ? Brightness.light : Brightness.dark,
      systemNavigationBarColor:
          isDark ? const Color(0xFF303030) : const Color(0xFFFAFAFA),
    ));
  }
}
