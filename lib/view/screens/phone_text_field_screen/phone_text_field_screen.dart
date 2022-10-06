import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:simplecashier/view/global_widegts/global_widgets.dart';
import 'package:simplecashier/view/screens/otp_screen/otp_screen.dart';

import '../../utils/utils.dart';

class PhoneFieldScreen extends StatefulWidget {
   const PhoneFieldScreen({super.key});

  @override
  State<PhoneFieldScreen> createState() => _PhoneFieldScreenState();
}

class _PhoneFieldScreenState extends State<PhoneFieldScreen> {
TextEditingController numberController=TextEditingController();

PhoneNumber number=PhoneNumber(isoCode: 'SA');
String data='';
final formKey=GlobalKey<FormState>();
@override
void dispose() {
  numberController.dispose();
  super.dispose();
}
bool loading=false;
// getNumber(String number)async{
//   PhoneNumber phoneNumber=await PhoneNumber.getRegionInfoFromPhoneNumber('SA');
//   setState(() {
//   phoneNumber=phoneNumber;
//   });
// }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: ListView(
            
            padding: const EdgeInsets.all(15),
            
            children: [
              Image.asset(Images.phoneField),
               const SizedBox(height: 10,),
              const Center(child: Text('REGISTER',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),)),
              const SizedBox(height: 20,),
              const Text("Enter your phone number to continue, we'll send you OTP to verify",textAlign: TextAlign.center,style: TextStyle(color: Colors.grey),),
                const SizedBox(height: 20,),
            Container(
              
              padding: const EdgeInsets.symmetric(horizontal: 10),
               decoration: BoxDecoration(
                                               
                                      border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.2)),
                                      color: Colors.white,
                                      boxShadow: [BoxShadow(
                                      offset: const Offset(-2, 2),
                                      blurRadius: 5,
                                      color: Colors.grey.withOpacity(.5)
                                      )],
                                      borderRadius: BorderRadius.circular(20),
                                     
                                                       ),
              child: InternationalPhoneNumberInput(
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return 'Enter your valid phone number';
                  }
                 
                  return null;
                },
                textFieldController: numberController,
                selectorConfig: const SelectorConfig(selectorType: PhoneInputSelectorType.BOTTOM_SHEET),
                
                onInputChanged: (PhoneNumber phoneNumber){
                      data=phoneNumber.phoneNumber!;
                  debugPrint('Country Info:${data.toString()}');
                 
                 
                },
                
                cursorColor: Colors.green,
                inputDecoration: const InputDecoration(
                 
                  hintText: 'Phone Number',
                border: InputBorder.none
                ),
                keyboardType: const TextInputType.numberWithOptions(signed: true,decimal: true),
            initialValue: number,
              ),
            ),
             SizedBox(height: MediaQuery.of(context).size.height*.3,),
           
            RoundedButtonWidget(text: 'Request OTP', press: ()async{
              if (formKey.currentState!.validate()) {
                setState(() {
                loading=true;
              });
          
      
      
              Navigator.push(context,MaterialPageRoute(builder: (_)=>OTPScreen(phoneNumber:  data,)));
              setState(() {
                loading=false;
              });
              }
              
            }, color: Colors.green, width: double.infinity, height: 50, loading: loading)
             
          ],),
        ),
      ),
    );
  }
}