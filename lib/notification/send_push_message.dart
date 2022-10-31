import 'dart:convert';

import 'package:http/http.dart'as http;
class PushMessage{
  sendPushMessage({required String title,required String token,required String body})async{
    try {
     await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
     headers: <String,String>{
      'content-Type':'application/json',
      'Authoriation':'key=AAAAqcS8UrI:APA91bFzR1wsEh-Mmsh467Go_gowTSDzh8EQTlpHGehWEYQAT459gx_ZCPFrP-MSwT4U5Yvbi9DdbQJjMGqhwPcUhN1aTAT5nfPJu4dejIxBl_hcb067aC9otBJs2QRuhkolQZD0873_',
     },
     body: jsonEncode(<String,dynamic>{
      'priority':'high',
      'data':<String,dynamic>{
        'click_action':'FLUTTER_NOTIFICATION_CLICK',
        'status':'done',
        'body':body,
        'title':title
      },
      "notification":<String,dynamic>{
        "body":body,
        "title":title,
        "android_channel-id":"kb",
      },
      "to":token
     })
     );
    } catch (e) {
      
    }
  }
}