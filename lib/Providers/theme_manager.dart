import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager with ChangeNotifier {
  bool _isDarkTheme = false;
  ThemeManager(this._isDarkTheme);

  get themeMode => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;
  get darkTheme => _isDarkTheme;

  toggleTheme() async {
    _isDarkTheme = !_isDarkTheme;
    (await SharedPreferences.getInstance()).setBool("darkTheme", _isDarkTheme);
    notifyListeners();
  }
}
