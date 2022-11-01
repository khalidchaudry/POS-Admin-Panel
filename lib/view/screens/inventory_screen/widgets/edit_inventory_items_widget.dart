import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../global_widgets/global_widgets.dart';
import '../../../utils/utils.dart';


class EditInventoryItemsScreen extends StatefulWidget {
   const EditInventoryItemsScreen({super.key, required this.productName, required this.stock,required this.companyName,   required this.image, required this.id});
   final String productName,companyName,image;
   final int stock;
   final String id;
  @override
  State<EditInventoryItemsScreen> createState() => _EditInventoryScreenState();
}
class _EditInventoryScreenState extends State<EditInventoryItemsScreen> {
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
TextEditingController? stockController;
TextEditingController? companyNameController;


Color color=Colors.green;
bool isButtonActive=true;

@override
  void initState() {
   productNameController=TextEditingController(text: widget.productName);
   stockController=TextEditingController(text: widget.stock.toString());
   companyNameController=TextEditingController(text: widget.companyName.toString());

super.initState();
  }
  @override
  void dispose() {
    productNameController?.dispose();
    stockController?.dispose();
    companyNameController?.dispose();
    super.dispose();
  }

 
 @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    final sizedBoxheight=SizedBox(height: size.height*.02,);
    bool nameField=false;
    bool isImageValue=false;
    bool stockBool=false;
     bool companyBool=false;
     bool addBtnBool=false;
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back),color: Colors.green,),
        elevation: 
        .5,
        title:  const Text('Edit Inventory',style: AppColor.appBarTextStyle,),backgroundColor: AppColor.appBarBgColor,),
      body: SafeArea(child: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(20),child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            pickImageMethod(isImageValue, context, size),
         sizedBoxheight,
         TextFieldWidget(
          keyboardType: TextInputType.text,
          moveNextField: TextInputAction.next,
          hintText: 'Product Name', boolCheck: nameField, controller: productNameController!),
          sizedBoxheight,
        
         TextFieldWidget(
            keyboardType: TextInputType.number,
          moveNextField: TextInputAction.next,
          hintText: 'Stock Quantity'.toString(), boolCheck: stockBool, controller: stockController!),
         sizedBoxheight,
         TextFieldWidget(
           keyboardType: TextInputType.text,
          moveNextField: TextInputAction.next,
          hintText: 'Company Name', boolCheck: companyBool, controller: companyNameController!),
         sizedBoxheight,
          SizedBox(
            width: double.infinity,
            child: NeumorphicButtonWidget(isCheck: addBtnBool, press: ()async{
             
                
    setState(() {
      loading=true;
    });
await inventoryController.updateStock(
productName: productNameController!.text.toString(),
   stock:stockController!.text.toString(),
    companyName: companyNameController!.text.toString(),
      file: image,
      id: widget.id.toString()
      );
      setState(() {
        loading=false;
      });
               
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
 const Text('Update Stock Image',style: TextStyle(color:Colors.grey,)),
const SizedBox(height: 3,),
 const Text('Best image dimensions is 320x650 px',style: TextStyle(color:Colors.grey,))
            ],
          ),
        );
  }
}