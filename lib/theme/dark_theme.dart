import 'package:flutter/material.dart';

class DarkTheme extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.system;
  ThemeMode get mode => _mode;

  void setMode(ThemeMode mode) {
    if (mode == _mode) return;
    _mode = mode;
    notifyListeners();
  }

  void toggle(bool isDark) => setMode(isDark ? ThemeMode.dark : ThemeMode.light);
}
