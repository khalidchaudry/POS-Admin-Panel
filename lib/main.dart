import 'package:flutter/material.dart';
import 'package:simplecashier/view/screens/home_screen/home_screen.dart';
main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Cashier',
      
      home:  HomeScreen(),
    );
  }
}
