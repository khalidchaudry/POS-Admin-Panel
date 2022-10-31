import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:uuid/uuid.dart';
import 'local_notifi_plugin_service.dart';

 class ColudMessagingService{
  // get Token
getToken()async{
  await FirebaseMessaging.instance.getToken().then((token) {
          saveToken(token: token);
    log('My Token is: ${token.toString()}');
  });
}
// save token
saveToken({required var token})async{
  var tokenDocId=const Uuid().v4();
  await FirebaseFirestore.instance.collection('token').doc(tokenDocId).set({
    'token':token,
    'tokenDocId':tokenDocId,
  });
}

  fourGroundMessage(){
    FirebaseMessaging.onMessage.listen(
      (message) {
        log("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          log(message.notification!.title.toString());
          log(message.notification!.body.toString());
          log("Fourground Data: ${message.data}");
          LocalNotificationPluginService().createanddisplaynotification(message);
        }
      },
    );
  }
  // This method only call when App in background and not terminated(not closed)
   appOpenButInBg(){
     FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        log("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          log('Message title:${message.notification!.title.toString()}');
          log('Message body:${message.notification!.body.toString()}');
          log("Background Data: ${message.data['_id']}");
        }
      },
    );
   }

}