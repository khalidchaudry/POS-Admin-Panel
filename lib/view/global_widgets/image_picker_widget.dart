import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/controllers.dart';
import '../utils/utils.dart';
import 'neumorphic_button_widget.dart';
 
class ImagePickerWidget extends StatefulWidget {
   ImagePickerWidget({super.key, required this.image});

 File image;

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  bool isImageValue=false;
   // Image Pick from camera
 imagePickFromCamera()async{
final pickImageFromCamera=await imageController.imagePicker(source: ImageSource.camera, context: context);
setState(() {
  widget.image=pickImageFromCamera;
});
 }
  // Image Pick from Gallery
  imagePickFromGallery()async{
final pickImageFromGallery=await imageController.imagePicker(source: ImageSource.gallery, context: context);
setState(() {
  widget.image=pickImageFromGallery;
});
 }
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
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
 widget.image==null?
 Image.asset(Images.pickImage,height: 100,width: double.infinity,):
 Image.file(widget.image,height: 200,fit: BoxFit.cover,),
 const SizedBox(height: 5,),
 const Text('Add Product Image',style: TextStyle(color:Colors.grey,)),
const SizedBox(height: 5,),
 const Text('Best image dimensions is 320x650 px',style: TextStyle(color:Colors.grey,))
              ],
            ),
          );
  }
}