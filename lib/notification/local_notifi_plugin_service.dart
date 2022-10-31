import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationPluginService{
  FlutterLocalNotificationsPlugin plugin=FlutterLocalNotificationsPlugin();
  initliaze(){
    InitializationSettings initializationSettings=const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher')
    );
    plugin.initialize(initializationSettings);
  }

 onDidReceiveNotificationResponse(NotificationResponse notificationResponse)  {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
    else{
      
    
    }
}
    createanddisplaynotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "kb",
          "kb",
          importance: Importance.max,
          priority: Priority.high,
        ),
      );

      await plugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data['_id'],
      );
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}