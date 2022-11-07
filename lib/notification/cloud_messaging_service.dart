import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

 class ColudMessagingService{
  // get Token
getToken()async{
  await FirebaseMessaging.instance.getToken(
    vapidKey: 'BN2Eqp-ZB5Dkrbd1qgcXBq6Fcu8-VGXj4UzNwUMBTjidPZ02e8RnArJu9eawfnnl5NimfId5g0hMEJRaBmPo8G4').then((token) {
          saveToken(token: token);
        debugPrint('Requesting permission...');
  debugPrint('My Token is: ${token.toString()}');
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
// When app is open
  fourGroundMessage(){
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        RemoteNotification? notification=message.notification;
        debugPrint("FirebaseMessaging.onMessage.listen");
        if (notification != null) {
          debugPrint(notification.title.toString());
          debugPrint(notification.body.toString());
          debugPrint("Fourground Data: ${message.data}");
        }
      },
    );
  }
  // This method only call when App in background and not terminated(not closed)
   appOpenButInBg(){
     FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        debugPrint("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          debugPrint('Message title:${message.notification!.title.toString()}');
          debugPrint('Message body:${message.notification!.body.toString()}');
          debugPrint("Background Data: ${message.data['_id']}");
        }
      },
    );
   }

}