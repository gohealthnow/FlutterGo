import 'package:flutter/material.dart';
import 'package:gohealth/src/app/splash_page.dart';
import 'package:gohealth/src/styles/theme.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    PreferencesTheme.setTheme();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    PreferencesTheme.setTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: PreferencesTheme.themeMode,
      builder: (BuildContext context, Brightness themeChanger, _) =>
          MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: const MaterialColor(0xFF005BE2, {
              50: Color(0xFFE3F2FD),
              100: Color(0xFFBBDEFB),
              200: Color(0xFF90CAF9),
              300: Color(0xFF64B5F6),
              400: Color(0xFF42A5F5),
              500: Color(0xFF2196F3),
              600: Color(0xFF1E88E5),
              700: Color(0xFF1976D2),
              800: Color(0xFF1565C0),
              900: Color(0xFF0D47A1),
            }),
            brightness: themeChanger,
            primaryColor: const Color(0xFF005BE2),
            fontFamily: 'Rubik'),
        home: const SplashPage(),
      ),
    );
  }
}
