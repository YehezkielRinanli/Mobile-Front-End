
import 'package:flutter/material.dart';
import 'package:wheel_of_fortune/screens/home_screen.dart';

//Fadil
import 'theme/theme_controller.dart';

void main() {
  runApp(const CraftOriginApp());
}

class CraftOriginApp extends StatelessWidget {
  const CraftOriginApp({super.key});

  @override
  //Fadil
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeMode,
      builder: (context, currentMode, child) {
        return MaterialApp(
          title: 'CraftOrigin',
          debugShowCheckedModeBanner: false,
          themeMode: currentMode,
          // LIGHT MODE: kembali ke tema awal HomeScreen
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: const Color(0xFF2A5940),
            brightness: Brightness.light,
          ),

          // DARK MODE: tetap tersedia
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF9BC7A5),
              onPrimary: Color(0xFF1E3A2B),
              secondary: Color(0xFFB5693B),
              surface: Color(0xFF1E3327),
              onSurface: Color(0xFFF1EFE9),
            ),
            scaffoldBackgroundColor: const Color(0xFF14231B),
            cardColor: const Color(0xFF1E3327),
            dividerColor: const Color(0xFF34483A),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF14231B),
              foregroundColor: Color(0xFFF1EFE9),
            ),
          ),

          home: const HomeScreen(),
        );
      },
    );
  }
}
//Fadil