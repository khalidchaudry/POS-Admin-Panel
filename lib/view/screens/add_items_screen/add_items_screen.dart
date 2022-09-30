
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simplecashier/view/utils/constants.dart';
import 'package:simplecashier/view/utils/utils.dart';


class AddItemsScreen extends StatefulWidget {
   const AddItemsScreen({super.key});

  @override
  State<AddItemsScreen> createState() => _AddItemsScreenState();
}

class _AddItemsScreenState extends State<AddItemsScreen> {
final fireStore=FirebaseFirestore.instance.collection('users');
File? image;
bool loading =false;
Color color=Colors.green;
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
await uploadController.fireStore(
  
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
          onTap: () {
            setState(() {
              color=Colors.purple;
            });
          },
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
           SizedBox(child: image==null?Image.asset(Images.pickImage,height: 200,):Image.file(image!,height: 200,))),
          const SizedBox(height: 20,),
          ElevatedButton(
      onPressed:(){
        addDataToFireStore();
            //  productNameController.clear();
            //   priceController.clear();
              
            //   descController.clear();
            //   barcodeController.clear();
              color=Colors.blueGrey;
              if (productNameController.text.isEmpty) {
      
      flushBarErrorMessage('Please enter product name', context);
              }
             else if (priceController.text.isEmpty) {
                       flushBarErrorMessage('Please Fill the price field', context);

              }
      } ,
      
      style: ElevatedButton.styleFrom(backgroundColor:color,minimumSize:  const Size(double.infinity, 40),shape: const StadiumBorder()),
      child: loading?const Center(child: CircularProgressIndicator(backgroundColor: AppColor.appBarBgColor,)):const Text('ADD'),)  
          
        ],),),
      )),
    );
  }
}