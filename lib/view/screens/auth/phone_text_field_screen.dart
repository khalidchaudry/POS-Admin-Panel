import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../../global_widgets/global_widgets.dart';
import '../../routes/route_name.dart';
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
String uid='';
final formKey=GlobalKey<FormState>();
@override
void dispose() {
  numberController.dispose();
  super.dispose();
}
// @override
// void initState() {
//   super.initState();
//   uid=FirebaseAuth.instance.currentUser!.uid;
// }
bool loading=false;
// getNumber(String number)async{
//   PhoneNumber phoneNumber=await PhoneNumber.getRegionInfoFromPhoneNumber('SA');
//   setState(() {
//   phoneNumber=phoneNumber;
//   });
// }
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: ListView(
            
            padding: const EdgeInsets.all(15),
            
            children: [
              Image.asset(Images.phoneField,
              width: size.width*.1,
              height: size.height*1,
              ),
              const Center(child: Text('LOGIN',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),)),
              const SizedBox(height: 20,),
              const Text("Enter your phone number to  verify and continue...",textAlign: TextAlign.center,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
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
                selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET),
                
                onInputChanged: (PhoneNumber phoneNumber){
                      data=phoneNumber.phoneNumber!;
                  debugPrint('Country Info:${data.toString()}');
               
                },
                
                cursorColor: Colors.green,
                inputDecoration: const InputDecoration(
                 
                  hintText: 'Phone Number',
                  hintStyle: TextStyle(fontWeight: FontWeight.bold),
                border: InputBorder.none
                ),
                keyboardType: const TextInputType.numberWithOptions(signed: true,decimal: true),
            initialValue: number,
              ),
            ),
             SizedBox(height: MediaQuery.of(context).size.height*.1,),
           NeumorphismButtonWidget( press: ()async{
              if (formKey.currentState!.validate()) {
                setState(() {
                loading=!loading;
              });
              // if (uid.isNotEmpty) {
      Navigator.pushNamedAndRemoveUntil(context,RouteName.userData,((route) => false));
              // }else{
        //  Navigator.pushNamed(context, RouteName.phoneScreen);
              // }
            
              //  if(auth.currentUser!=null){
        // return Navigator.pushNamed(context, RouteName.phoneScreen);
        // }
   }
   }, color: Colors.white, width: double.infinity, height: 50, radius: 10, isCheck: loading, child: const Text('Login',style: TextStyle(fontWeight: FontWeight.bold),))
          ],),
        ),
      ),
    );
  }
}