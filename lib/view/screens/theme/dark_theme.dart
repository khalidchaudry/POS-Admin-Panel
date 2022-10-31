import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData dark = ThemeData(
  primarySwatch: Colors.green,
  brightness: Brightness.dark,
 hintColor: Colors.white,
 appBarTheme:  const AppBarTheme(
systemOverlayStyle: SystemUiOverlayStyle.dark
  ),
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
);
