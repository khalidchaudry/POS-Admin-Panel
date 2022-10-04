import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  SharedPreferences sp;
  ThemeProvider({required this.sp}) {
    _loadCurrentTheme();
  }

  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;

  void toggleTheme() {
    _darkTheme = !_darkTheme;
    sp.setBool('dark',_darkTheme);
    notifyListeners();
  }

  void _loadCurrentTheme()  {
    _darkTheme = sp.getBool('dark') ??false;
    notifyListeners();
  }
}
