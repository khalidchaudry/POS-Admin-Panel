import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {}
    // Navigator.push(context, MaterialPageRoute(builder: (_)=> PhoneFieldScreen()))
      
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Container(
      // padding: const EdgeInsets.only(bottom:30),
     alignment: Alignment.bottomCenter,
      decoration: const BoxDecoration(
         color: Colors.white,
        image: DecorationImage(image: AssetImage(Images.bg),fit: BoxFit.cover)),
      child: Center(child: Image.asset(Images.splashImage,width: 100,height: 100,)),
    );
  }
}