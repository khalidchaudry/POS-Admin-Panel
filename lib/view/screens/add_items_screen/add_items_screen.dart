import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:simplecashier/provider/product_provider.dart';
import 'package:simplecashier/view/utils/utils.dart';

import '../../global_widgets/global_widgets.dart';

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
 
 String code='';
// Controllers
TextEditingController productNameController=TextEditingController();
TextEditingController priceController=TextEditingController();
TextEditingController descController=TextEditingController();
TextEditingController barcodeController=TextEditingController();
TextEditingController discountController=TextEditingController();
MobileScannerController cameraController = MobileScannerController();
  @override
  void dispose() {
    productNameController.dispose();
    priceController.dispose();
    descController.dispose();
    barcodeController.dispose();
    discountController.dispose();
    super.dispose();
  }

 // Image Pick from camera
 imagePickFromCamera()async{
final pickImageFromCamera=await imageController.imagePicker(source: ImageSource.camera, context: context);
setState(() {
  image=pickImageFromCamera;
});
 }
  // Image Pick from Gallery
  imagePickFromGallery()async{
final pickImageFromGallery=await imageController.imagePicker(source: ImageSource.gallery, context: context);
setState(() {
  image=pickImageFromGallery;
});
 }
  
  @override
  void initState() {
    barcodeController.text=code;
    super.initState();
  }
  @override
  Widget build(BuildContext context) =>OrientationBuilder(builder: (context, orientation) {
    final isPortrait=orientation==Orientation.portrait;
    ProductProvider addItemProvider=Provider.of(context);
     final size=MediaQuery.of(context).size;
    final sizedBoxheight=isPortrait?SizedBox(height: size.height*.02,):SizedBox(height: size.height*.04);
    bool nameField=false;
    bool isImageValue=false;
    bool priceBool=false;
     bool descBool=false;
     bool addBtnBool=false;
      bool barcodeBool=false;
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 
        .5,
        title:  const Text(AppString.appBarAddItem,style: AppColor.appBarTextStyle,),backgroundColor: AppColor.appBarBgColor,),
      body: SafeArea(child: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(20),child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            pickImageMethod(isImageValue, context, size),
         sizedBoxheight,
         TextFieldWidget(
          keyboardType: TextInputType.text,
          moveNextField: TextInputAction.next,
          hintText: 'Product Name', boolCheck: nameField, controller: productNameController),
          sizedBoxheight,
        
         TextFieldWidget(
            keyboardType: TextInputType.number,
          moveNextField: TextInputAction.next,
          hintText: 'Product Price', boolCheck: priceBool, controller: priceController),
         sizedBoxheight,
         TextFieldWidget(
           keyboardType: TextInputType.text,
          moveNextField: TextInputAction.next,
          hintText: 'Product Description', boolCheck: descBool, controller: descController),
         sizedBoxheight,
          NeumorphicButtonWidget(
            isCheck: barcodeBool,
            press: (){
              setState(() {
                barcodeBool=!barcodeBool;
              });
            },
            color: Colors.transparent,
            child: TextField(  
          keyboardType: TextInputType.number,
            controller: barcodeController,
            textInputAction: TextInputAction.next,
              decoration:   InputDecoration(hintText: 'Product Barcode',           
              border: InputBorder.none,
              suffixIcon: 
              TextButton(onPressed:(){  
                Navigator.push(context, MaterialPageRoute(builder: (_)=>MobileScanner(
          allowDuplicates: false,
          controller: MobileScannerController(
            facing: CameraFacing.back, torchEnabled: true),
          onDetect: (barcode, args) {
            if (barcode.rawValue == null) {
              flushBarErrorMessage(barcode.rawValue.toString(), context);
              debugPrint('Failed to scan Barcode');
            } else {
            code = barcode.rawValue!;
            setState(() {
              Navigator.pop(context);
     barcodeController.text=code;
            });
          flushBarErrorMessage('Barcode found: $code', context);
              debugPrint('Barcode found! $code');
            }
          }),));
              }, 
               child:  Image.asset(Images.qr,width: 30,height:30))
              ),
              
              ),
            ),
                           const SizedBox(height: 7,),

         const Text('Optional',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                  const SizedBox(height: 5,),
         TextFieldWidget(
           keyboardType: TextInputType.number,
          moveNextField: TextInputAction.done,
          hintText: 'Discount in %', boolCheck: descBool, controller: discountController),
         sizedBoxheight,
          SizedBox(
            width: double.infinity,
            child: NeumorphicButtonWidget(isCheck: addBtnBool, press: ()async{
              if (image!=null&&productNameController.text.isNotEmpty && priceController.text.isNotEmpty && 
              descController.text.isNotEmpty && barcodeController.text.isNotEmpty) {
                 setState(() {
      loading=true;
    });
await uploadController.fireStore(
  productName: productNameController.text,
   productPrice: priceController.text,
    productDesc: descController.text,
     productBarcode: barcodeController.text,
     productDiscount:discountController.text,
      file: image
      );
      setState(() {
        loading=false;
      });
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
    return NeumorphicButtonWidget(
           color: Colors.transparent,
       isCheck: isImageValue,
          press: () { 
            showDialog(context: context, builder: (_){
                 final dialogHeight=SizedBox(height: size.height*.02,);
              bool cameraValue=false;
                 bool galleryValue=false;
                 bool cancel=false;
              return SimpleDialog(
                
             contentPadding: const EdgeInsets.all(10),
                children: [
                   const Text('How do you want to choose product picture',
                   textAlign: TextAlign.center,
                   style: TextStyle(color:Colors.grey,)),
                   dialogHeight,
                  NeumorphicButtonWidget(isCheck: cameraValue,
                   color: Colors.transparent,
                  press: () {  
                    imagePickFromCamera();
                    Navigator.pop(context);
                  },
                  child:  const Text('Using Camera',textAlign: TextAlign.center,),),
                  dialogHeight,
                  NeumorphicButtonWidget(isCheck: galleryValue,
                   color: Colors.transparent,
                  press:(){
                    imagePickFromGallery();
                     Navigator.pop(context);
                  },
                  child:  const Text('Using Device Storage',textAlign: TextAlign.center,),),
                  dialogHeight,
                   NeumorphicButtonWidget(isCheck: cancel,
                   color: Colors.transparent,
                  press: ()=>Navigator.pop(context),
                  child:  const Text('Cancel',textAlign: TextAlign.center,),),
                ],
              );
            });
           },
          child: Column(
            children: [
 
 image==null?
 Image.asset(Images.pickImage,height: 150,width: double.infinity,):
 Image.file(image!,height: 150,width: double.infinity),
 const SizedBox(height: 5,),
 const Text('Add Product Image',style: TextStyle(color:Colors.grey,)),
const SizedBox(height: 5,),
 const Text('Best image dimensions is 320x650 px',style: TextStyle(color:Colors.grey,))
            ],
          ),
        );
  }
  }

 