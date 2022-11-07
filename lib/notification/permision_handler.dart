import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class PermissionHandler{
  // Get User Permission
  getPermission()async{
    FirebaseMessaging messaging = FirebaseMessaging.instance;
NotificationSettings settings = await messaging.requestPermission(
  alert: true,
  announcement: false,
  badge: true,
  carPlay: false,
  criticalAlert: false,
  provisional: false,
  sound: true,
);
if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  debugPrint('User granted permission');
} else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
  debugPrint('User granted provisional permission');
} else {
  debugPrint('User declined or has not accepted permission');
}
  }
}