import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../view/utils/constants.dart';
import '../view/utils/utils.dart';

class OTPController {
    phoneVerification({required String verificationId,required BuildContext context,required String number})async{
    await auth.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: (PhoneAuthCredential credential)async{
        await auth.signInWithCredential(credential).then((value) { 
          if (value.user!=null) {
            flushBarErrorMessage('Successfully login! ', context);
          }
          });
      },
       verificationFailed: (FirebaseAuthException error){
        flushBarErrorMessage(error.toString(), context);
       }, 
       codeSent: (String verificationId,int? resendToken){
        verificationId=verificationId;
        
      
       },
        codeAutoRetrievalTimeout: 
        (String verificationID){
           verificationId=verificationID;
         
        }
        ,timeout:const Duration(seconds: 60));
  }

}