import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simplecashier/view/screens/home_screen/home_screen.dart';
import 'package:simplecashier/view/utils/app_colors.dart';
main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: AppColor.appBarBgColor));
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Cashier',
      
      home:  HomeScreen(),
    );
  }
}
