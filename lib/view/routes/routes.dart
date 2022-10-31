import 'package:flutter/material.dart';
import 'package:simplecashier/view/routes/route_name.dart';
import 'package:simplecashier/view/screens/screens.dart';
import 'package:simplecashier/view/utils/firebase.dart';

class Routes{
  static Route<dynamic> routeGenerator(RouteSettings settings){
    switch (settings.name) {
       case RouteName.phoneScreen:
        if(auth.currentUser!=null){
          return MaterialPageRoute(builder: (_)=> const BottomNavBar());
        }else{
        return MaterialPageRoute(builder: (_)=> const PhoneFieldScreen());
        }
    
      default:
      throw const FormatException("Route not found");
    }
  }
}

     
//  case RouteName.splashScreen:
//         return MaterialPageRoute(builder: (_)=>const SplashScreen());
// case RouteName.selectLanguageScreen:
        // return MaterialPageRoute(builder: (_)=>const SelectLanguageScreen());