import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:simplecashier/view/screens/select_language_screen/select_language_screen.dart';
import 'package:simplecashier/view/utils/app_colors.dart';


Future main() async{
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
   FlutterNativeSplash.remove();
   initialization();
  //  EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp
    ]
  );
  runApp(const MyApp());
}

Future initialization()async{
  await Future.delayed(const Duration(seconds: 3));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: AppColor.appBarBgColor));
    return   const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Cashier',
      
      // localizationsDelegates:context.localizationDelegates,
      // supportedLocales: context.supportedLocales,
      // locale: context.locale,
        home:  SelectLanguageScreen(),
    );
  }
}
