import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  
  primarySwatch: Colors.green,
  brightness: Brightness.light,
  
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
);