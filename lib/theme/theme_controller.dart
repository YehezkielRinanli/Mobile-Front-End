//Fadil
import 'package:flutter/material.dart';

class ThemeController {
  ThemeController._();

  static final ValueNotifier<ThemeMode> themeMode =
      ValueNotifier<ThemeMode>(ThemeMode.light);
}
//Fadil