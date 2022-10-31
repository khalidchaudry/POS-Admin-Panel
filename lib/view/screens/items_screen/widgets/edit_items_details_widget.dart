import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:simplecashier/provider/product_provider.dart';
import '../../../global_widgets/global_widgets.dart';
import '../../../utils/utils.dart';


class EditItemsScreen extends StatefulWidget {
   const EditItemsScreen({super.key, required this.productName, required this.productPrice,required this.desc,  required this.barcode, required this.image, required this.id, required this.discount});
   final String productName,desc,image;
   final double productPrice,discount;
   final String barcode;
   final String id;

  @override
  State<EditItemsScreen> createState() => _EditItemsScreenState();
}

class _EditItemsScreenState extends State<EditItemsScreen> {
final fireStore=FirebaseFirestore.instance.collection('users');
File? image;
bool loading =false;
 String code='';
 imagePickFromCamera()async{
final pickImageFromCamera=await imageController.imagePicker(source: ImageSource.camera, context: context);
setState(() {
  image=pickImageFromCamera;
});
 }
  // Image Pick from Gallery
  imagePickFromGallery()async{
final pickImageFromCamera=await imageController.imagePicker(source: ImageSource.gallery, context: context);
setState(() {
  image=pickImageFromCamera;
});
 }
TextEditingController? productNameController;
TextEditingController? priceController;
TextEditingController? descController;
TextEditingController? barcodeController;
TextEditingController? discountController;

Color color=Colors.green;
bool isButtonActive=true;

@override
  void initState() {
   productNameController=TextEditingController(text: widget.productName);
   priceController=TextEditingController(text: widget.productPrice.toString());
   descController=TextEditingController(text: widget.desc.toString());
   barcodeController=TextEditingController(text: widget.barcode.toString());
      discountController=TextEditingController(text: widget.discount.toString());

super.initState();
  }
  @override
  void dispose() {
    productNameController?.dispose();
    priceController?.dispose();
    descController?.dispose();
    barcodeController?.dispose();
    discountController?.dispose();
    super.dispose();
  }

 
 @override
  Widget build(BuildContext context) {
    ProductProvider editItemProvider=Provider.of(context);
    final size=MediaQuery.of(context).size;
    final sizedBoxheight=SizedBox(height: size.height*.02,);
    bool nameField=false;
    bool isImageValue=false;
    bool priceBool=false;
     bool descBool=false;
     bool addBtnBool=false;
      bool barcodeBool=false;
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back),color: Colors.green,),
        elevation: 
        .5,
        title:  const Text(AppString.appBarEditItem,style: AppColor.appBarTextStyle,),backgroundColor: AppColor.appBarBgColor,),
      body: SafeArea(child: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(20),child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            pickImageMethod(isImageValue, context, size),
         sizedBoxheight,
         TextFieldWidget(
          keyboardType: TextInputType.text,
          moveNextField: TextInputAction.next,
          hintText: widget.productName, boolCheck: nameField, controller: productNameController!),
          sizedBoxheight,
        
         TextFieldWidget(
            keyboardType: TextInputType.number,
          moveNextField: TextInputAction.next,
          hintText: widget.productPrice.toString(), boolCheck: priceBool, controller: priceController!),
         sizedBoxheight,
         TextFieldWidget(
           keyboardType: TextInputType.text,
          moveNextField: TextInputAction.next,
          hintText: widget.desc, boolCheck: descBool, controller: descController!),
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
              decoration:   InputDecoration(hintText:widget.barcode.toString(),
           
              border: InputBorder.none,
              suffixIcon:TextButton(onPressed:(){  
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
     barcodeController?.text=code;
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
          hintText: widget.discount.toString(), boolCheck: descBool, controller: discountController!),
         sizedBoxheight,
         sizedBoxheight,
          SizedBox(
            width: double.infinity,
            child: NeumorphicButtonWidget(isCheck: addBtnBool, press: ()async{
              if (image!=null&&productNameController!.text.isNotEmpty && priceController!.text.isNotEmpty && 
              descController!.text.isNotEmpty && barcodeController!.text.isNotEmpty) {
                
    setState(() {
      loading=true;
    });
await uploadController.updateFireStore(
productName: productNameController!.text.toString(),
   productPrice:priceController!.text.toString(),
    productDesc: descController!.text.toString(),
     productBarcode: barcodeController!.text.toString(),
     productDiscount: discountController!.text.toString(),
      file: image,
      id: widget.id.toString(),
      );
      setState(() {
        loading=false;
      });
  
              }else{
                 flushBarErrorMessage('Please fill all fields', context);
              }
               
            }, color: AppColor.navBarBxColor, child:loading?const Center(child: CircularProgressIndicator(backgroundColor: AppColor.appBarBgColor,)):const Text('UPDATE',textAlign: TextAlign.center,style: TextStyle(color: Colors.white),)),
          ),
         
          
        ],),),
      )),
    );
  }

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
 Image.network(widget.image,height: 150,fit: BoxFit.cover,width: double.infinity,):
 Image.file(image!,height: 150,fit: BoxFit.cover,width: double.infinity),
 const SizedBox(height: 7,),
 const Text('Update Product Image',style: TextStyle(color:Colors.grey,)),
const SizedBox(height: 3,),
 const Text('Best image dimensions is 320x650 px',style: TextStyle(color:Colors.grey,))
            ],
          ),
        );
  }
}