
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simplecashier/view/utils/app_colors.dart';
import 'package:simplecashier/view/utils/app_strings.dart';
import 'package:simplecashier/view/utils/constants.dart';
import 'package:simplecashier/view/utils/images.dart';

import '../home_screen/widgets/rounded_button_widget.dart';

class AddItemsScreen extends StatefulWidget {
   const AddItemsScreen({super.key});

  @override
  State<AddItemsScreen> createState() => _AddItemsScreenState();
}

class _AddItemsScreenState extends State<AddItemsScreen> {
final fireStore=FirebaseFirestore.instance.collection('users');
File? image;
bool loading =false;
imagePicker()async{
  final  imagePickers= await ImagePicker().pickImage(source: ImageSource.gallery);
  final pickFile=File(imagePickers!.path);
   setState(() {
   image=pickFile;
 });}
TextEditingController productNameController=TextEditingController();
TextEditingController priceController=TextEditingController();
TextEditingController descController=TextEditingController();
TextEditingController barcodeController=TextEditingController();
bool isButtonActive=true;
@override
  void initState() {
   
    productNameController.addListener(() {
      final isButton=productNameController.text.isNotEmpty;
      setState(() {
        isButton==isButtonActive;
      });
     });

    
    super.initState();
  }
  @override
  void dispose() {
    productNameController.dispose();
    priceController.dispose();
    descController.dispose();
    barcodeController.dispose();
    super.dispose();
  }

  addDataToFireStore()async{
    setState(() {
      loading=true;
    });
await controller.fireStore(
  
  productName: productNameController.text,
   productPrice: priceController.text,
    productDesc: descController.text,
     productBarcode: barcodeController.text,
      file: image
      );
      setState(() {
        loading=false;
      });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text(AppString.appBarAddItem),backgroundColor: AppColor.appBarBgColor,),
      body: SafeArea(child: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(20),child: Column(children:  [
          TextField(maxLength: 20,
          controller: productNameController,
          textInputAction: TextInputAction.next,
            decoration: InputDecoration(label: const Text('Name of the product'),
          errorText: 'Required',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15*2),
            
            ),
            
            ),
          ),
          const SizedBox(height: 20,),
          TextField(
            controller: priceController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(label: const Text('Price'),
             errorText: 'Required',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15*2)),
           
            ),
          ),
          const SizedBox(height: 20,),
          TextField(maxLength: 100,
          controller: descController,
            textInputAction: TextInputAction.next,

            decoration: InputDecoration(label: const Text('Description'),
            
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15*2)),
            
            ),
          ),
          const SizedBox(height: 20,),
          TextField(
            controller: barcodeController,
          keyboardType: TextInputType.number,
            decoration: InputDecoration(label: const Text('Barcode'),
            
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          
            ),
          ),
          const SizedBox(height: 20,),
           TextButton(
            onPressed: 
              imagePicker,
            
            child: 
           SizedBox(height: 200,width: double.infinity,child: image==null?Image.asset(Images.pickImage):Image.file(image!,fit: BoxFit.cover,))),
          const SizedBox(height: 20,),
          
          RoundedButtonWidget(text: 'Add',loading: loading, press: (){
            String id=DateTime.now().millisecondsSinceEpoch.toString();
//            await  fireStore.doc(id).set({
//             'productName': productNameController.text.toString(),
//    'productPrice': priceController.text.toString(),
//     'productDesc': descController.text.toString(),
//      'productBarcode': barcodeController.text.toString(),
//       // 'file': image
//            }).then((value)=>Fluttertoast.showToast(msg: value.toString())).onError((error, stackTrace) { Fluttertoast.showToast(msg: error.toString());
//  });
            addDataToFireStore();
             productNameController.clear();
              priceController.clear();
              image=null;
              descController.clear();
              barcodeController.clear();
          }, color: Colors.green, width: double.infinity, height: 50)
        ],),),
      )),
    );
  }
}