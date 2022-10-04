import 'package:flutter/material.dart';
import 'package:simplecashier/view/routes/route_name.dart';
import 'package:simplecashier/view/screens/screens.dart';

class Routes{
  static Route<dynamic> routeGenerator(RouteSettings settings){
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (_)=>const SplashScreen());
      case RouteName.selectLanguageScreen:
        return MaterialPageRoute(builder: (_)=>const SelectLanguageScreen());
         case RouteName.settingsscreen:
        return MaterialPageRoute(builder: (_)=> SettingsScreen());
         case RouteName.homescreen:
        return MaterialPageRoute(builder: (_)=>const HomeScreen());
      default:
              throw const FormatException("Route not found");
    }
  }
}