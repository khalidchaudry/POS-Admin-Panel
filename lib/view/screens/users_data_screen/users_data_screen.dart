import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:simplecashier/view/routes/route_name.dart';
import 'package:simplecashier/view/utils/utils.dart';

import '../../global_widgets/global_widgets.dart';

class UserDataScreen extends StatefulWidget {
   const UserDataScreen({super.key});
  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  
final fireStore=FirebaseFirestore.instance.collection('users');
bool loading =false;
Color color=Colors.green;
 
 String code='';
// Controllers
TextEditingController userNameController=TextEditingController();
TextEditingController companyNameController=TextEditingController();
TextEditingController lienceNumberController=TextEditingController();
TextEditingController addressController=TextEditingController();
  @override
  void dispose() {
    userNameController.dispose();
    companyNameController.dispose();
    lienceNumberController.dispose();
    addressController.dispose();
    super.dispose();
  }
  // Image Picker
String fileName='';
 Uint8List? filePicker;
 selectFile() async {
    FilePickerResult? fileResult = await FilePicker.platform.pickFiles();
    if (fileResult != null) {
      setState(() {
        filePicker = fileResult.files.first.bytes;
        fileName=fileResult.files.first.name;
      });
    }
    debugPrint(fileName.toString());
  }

  @override
  Widget build(BuildContext context) =>OrientationBuilder(builder: (context, orientation) {
    final isPortrait=orientation==Orientation.portrait;
     final size=MediaQuery.of(context).size;
    final sizedBoxheight=isPortrait?SizedBox(height: size.height*.02,):SizedBox(height: size.height*.04);
    bool nameField=false;
    bool isImageValue=false;
    bool priceBool=false;
     bool descBool=false;
     bool addBtnBool=false;
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 
        .5,
        title:  const Text(AppString.userData,style: AppColor.appBarTextStyle,),backgroundColor: AppColor.appBarBgColor,),
      body: SafeArea(child: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(20),child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            pickImageMethod(isImageValue, context, size),
         sizedBoxheight,
         TextFieldWidget(
          keyboardType: TextInputType.text,
          moveNextField: TextInputAction.next,
          hintText: 'User Name', boolCheck: nameField, controller: userNameController),
          sizedBoxheight,
        
         TextFieldWidget(
            keyboardType: TextInputType.text,
          moveNextField: TextInputAction.next,
          hintText: 'Company Name', boolCheck: priceBool, controller: companyNameController),
         sizedBoxheight,
         TextFieldWidget(
           keyboardType: TextInputType.text,
          moveNextField: TextInputAction.next,
          hintText: 'License Number', boolCheck: descBool, controller: lienceNumberController),
         sizedBoxheight,
         TextFieldWidget(
           keyboardType: TextInputType.text,
          moveNextField: TextInputAction.done,
          hintText: 'Address', boolCheck: descBool, controller: addressController),
         sizedBoxheight,
          SizedBox(
            width: double.infinity,
            child: NeumorphicButtonWidget(isCheck: addBtnBool, press: ()async{
              
              if (companyNameController.text.isNotEmpty && userNameController.text.isNotEmpty && 
              lienceNumberController.text.isNotEmpty && addressController.text.isNotEmpty) {
                 setState(() {
      loading=true;
    });
await companyController.companyData(
  userName: userNameController.text,
   companyName: companyNameController.text,
    licenseNumber: lienceNumberController.text,
     address: addressController.text,
      file: filePicker
      );
      setState(() {
        loading=false;
      });
      Navigator.pushNamedAndRemoveUntil(context,RouteName.bottomNavBar,((route) => false));
              }else{
                 flushBarErrorMessage('Please fill all fields', context);
              }
                color=Colors.transparent;
               
            }, color: AppColor.navBarBxColor, child:loading?const Center(child: CircularProgressIndicator(backgroundColor: AppColor.appBarBgColor,)):const Text('ADD',textAlign: TextAlign.center,style: TextStyle(color: Colors.white),)),
          ),
         
        ],),),
      )),
    );
}); 


 NeumorphicButtonWidget pickImageMethod(bool isImageValue, BuildContext context, Size size) {
  bool galleryValue=false;
    return NeumorphicButtonWidget(
           color: Colors.transparent,
       isCheck: isImageValue,
          press: () { 
          },
           child:NeumorphicButtonWidget(isCheck: galleryValue,
                   color: Colors.transparent,
                  press:()async{
                selectFile();
                  },
          child: Column(
            children: [

 filePicker==null?
 Image.asset(Images.pickImage,height: 150,width: double.infinity,):
 Image.memory(filePicker!,height: 150,width: double.infinity),
 const SizedBox(height: 5,),
 const Text('Add your company logo',style: TextStyle(color:Colors.grey,)),
const SizedBox(height: 5,),
 const Text('Best filePicker dimensions is 320x650 px',style: TextStyle(color:Colors.grey,))
            ],
          ),
    ));
  }
  }