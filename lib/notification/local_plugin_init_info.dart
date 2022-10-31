import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

 class LocalPluginInitInfo{
  late BuildContext context;
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
  initInfo(){
  var androidInitialize=const AndroidInitializationSettings('@mipmap/ic_launcher');
 var initializationSettings= InitializationSettings(android: androidInitialize);
 flutterLocalNotificationsPlugin.initialize(initializationSettings,
  onDidReceiveNotificationResponse:onDidReceiveNotificationResponse);
}
  void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
    else{
      
    
    }
}

}