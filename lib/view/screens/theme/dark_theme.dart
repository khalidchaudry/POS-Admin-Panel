import 'package:flutter/material.dart';

ThemeData dark = ThemeData(
  primarySwatch: Colors.green,
  brightness: Brightness.dark,
  hintColor: Colors.white,
  
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
);
