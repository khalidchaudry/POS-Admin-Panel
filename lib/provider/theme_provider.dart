import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  SharedPreferences sp;
  var _themeMode=ThemeMode.light;
  ThemeProvider({required this.sp}) {
    _loadCurrentTheme();
  }
 
   bool _darkTheme = false;
    final bool _lightTheme=false;
    ThemeMode get themeMode=>_themeMode;
   bool get lightTheme=>_lightTheme;
  bool get darkTheme => _darkTheme;

  void toggleTheme({required ThemeMode themeMode}) {
    _themeMode=themeMode;
    _darkTheme=!_darkTheme;
    // _lightTheme=!lightTheme;
    sp.setBool('dark',_darkTheme);
    // sp.setBool('light',_lightTheme);
    notifyListeners();
  }

  void _loadCurrentTheme()  {
    _darkTheme = sp.getBool('dark') ??false;
    // _lightTheme=sp.getBool('light')??false;
    notifyListeners();
  }
}
