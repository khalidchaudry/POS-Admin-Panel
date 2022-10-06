import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:simplecashier/view/routes/route_name.dart';

import '../../utils/constants.dart';
import '../../utils/utils.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key, required this.phoneNumber,});

final String phoneNumber;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
   String _verificationID='';
var token;
TextEditingController oTPController=TextEditingController();

final formKey=GlobalKey<FormState>();
final GlobalKey<ScaffoldState> _scaffoldKey=GlobalKey<ScaffoldState>();

@override
  void initState() {
   phoneVerification();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Images.lock),
                   const SizedBox(height: 10,),
                  const Text('VERIFICATION CODE',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 20,),
                  RichText(text:  TextSpan(children: [
                    const TextSpan(text:"Please enter the verification code that we have sent to your mobile number  ", style: TextStyle(color: Colors.grey,fontSize: 15)),
                    TextSpan(text:widget.phoneNumber,style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 17))
                  ])),
              
                 
                    const SizedBox(height: 20,),
               Pinput(
                controller: oTPController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return'First enter verification code';
                  }
                  return null;
                },
                length: 6,
               
                  defaultPinTheme: PinTheme(
                    width: 50,
                    height: 50,
                    
                    textStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                    decoration:BoxDecoration(
                     border: Border.all(color: Colors.green),
                      shape: BoxShape.circle)
                  ),
                 
                  onSubmitted: (value) {
                    try {
                      auth.signInWithCredential(PhoneAuthProvider.credential(
                    verificationId: _verificationID, smsCode: value)).then((value) {
                      if (value.user!=null) {
                        Navigator.pushNamedAndRemoveUntil(context,RouteName.selectLanguageScreen,((route) => false));
                        flushBarErrorMessage('invalid OTP', context);
                      }
                    });
                  } catch (e) {
                    FocusScope.of(context).unfocus();
                    _scaffoldKey.currentState!.showBottomSheet((context) => const SnackBar(content: Text('invalid OTP')));
                  }}
                 
                ),
                const SizedBox(height: 20,),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                  const Text("Didn't receive the code?"),
                   TextButton(onPressed: phoneVerification, child:const Text('Resend'),),
                 ],
               ),
                SizedBox(height: MediaQuery.of(context).size.height*.2,),
                Container(
                  width: 70,height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.green,width: 2)),
                    child: IconButton(onPressed: (){
                      if (formKey.currentState!.validate()) {
                        
                        if (auth.currentUser!.phoneNumber!=null) {
                          debugPrint('OTP is:${oTPController.text.toString()}');
                          debugPrint('verify ID is:$_verificationID');
                           debugPrint('verify code is:$token');
                          flushBarErrorMessage('Successfully Login', context);
                        Navigator.pushNamedAndRemoveUntil(context,RouteName.selectLanguageScreen,((route) => false));
                        }
                      }
                    }, icon: const Icon(Icons.arrow_forward,color: Colors.green,)),
                    )
                 
              ],),
            ),
          ),
        ),
      ),
    );
  }

   phoneVerification()async{
    await auth.verifyPhoneNumber(
      phoneNumber: widget.phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential)async{
        await auth.signInWithCredential(credential).then((value) { 
          if (value.user!=null) {
            Navigator.pushNamedAndRemoveUntil(context,RouteName.selectLanguageScreen,((route) => false));
            flushBarErrorMessage('Successfully login! ', context);
          }
          });
      },
       verificationFailed: (FirebaseAuthException error){
        flushBarErrorMessage(error.toString(), context);
       }, 
       codeSent: (String verificationId,int? resendToken){
        
        setState(() {
          token=resendToken;
            _verificationID=verificationId;
        });
      
       },
        codeAutoRetrievalTimeout: 
        (String verificationID){
          setState(() {
            _verificationID=verificationID;
          });
        }
        ,timeout:const Duration(seconds: 60));
  }
}
