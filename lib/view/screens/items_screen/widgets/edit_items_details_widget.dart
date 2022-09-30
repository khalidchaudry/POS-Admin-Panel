
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simplecashier/view/utils/constants.dart';

import '../../../utils/utils.dart';


class EditItemsScreen extends StatefulWidget {
   const EditItemsScreen({super.key, required this.productName, required this.productPrice,required this.desc,  required this.barcode, required this.image, required this.id});
   final String productName,desc,image;
   final double productPrice;
   final int barcode;
   final String id;
  @override
  State<EditItemsScreen> createState() => _AddItemsScreenState();
}

class _AddItemsScreenState extends State<EditItemsScreen> {
final fireStore=FirebaseFirestore.instance.collection('users');
File? image;
bool loading =false;
imagePicker()async{
  final  imagePickers= await ImagePicker().pickImage(source: ImageSource.gallery);
  final pickFile=File(imagePickers!.path);
   setState(() {
   image=pickFile;
 });}
TextEditingController? productNameController;
TextEditingController? priceController;
TextEditingController? descController;
TextEditingController? barcodeController;
Color color=Colors.green;
bool isButtonActive=true;
@override
  void initState() {
   productNameController=TextEditingController(text: widget.productName);
   priceController=TextEditingController(text: widget.productPrice.toString());
   descController=TextEditingController(text: widget.desc.toString());
   barcodeController=TextEditingController(text: widget.barcode.toString());
super.initState();
  }
 

  updateFireStoreData()async{
    setState(() {
      loading=true;
    });
await uploadController.updateFireStore(
  
  productName: productNameController!.text.toString(),
   productPrice:priceController!.text.toString(),
    productDesc: descController!.text.toString(),
     productBarcode: barcodeController!.text.toString(),
      file: image,
      id: widget.id.toString(),
      );
      setState(() {
        loading=false;
      });
  }
  @override
  Widget build(BuildContext context) {
    debugPrint(priceController.toString());
    return  Scaffold(
      appBar: AppBar(title: const Text(AppString.appBarEditItem),backgroundColor: AppColor.appBarBgColor,),
      body: SafeArea(child: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(20),child: Column(children:  [
          TextField(
             onTap: () {
            setState(() {
              color=Colors.purple;
            });
          },
            maxLength: 20,
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
           SizedBox(child: image==null?Image.network(widget.image.toString(),height: 200,):Image.file(image!,height: 200,))),
          const SizedBox(height: 20,),
          ElevatedButton(
      onPressed:
        (){updateFireStoreData();
         if (productNameController!.text.isEmpty) {
      
      flushBarErrorMessage('Please enter product name', context);
              }
             else if (priceController!.text.isEmpty) {
                       flushBarErrorMessage('Please Fill the price field', context);

              }
        setState(() {
color=Colors.blueGrey;        });
        },
      
      style: ElevatedButton.styleFrom(backgroundColor:color,minimumSize:  const Size(double.infinity, 40),shape: const StadiumBorder()),
      child: loading?const Center(child: CircularProgressIndicator(backgroundColor: Colors.green,)):const Text('SAVE'),)  
          
        ],),),
      )),
    );
  }
}