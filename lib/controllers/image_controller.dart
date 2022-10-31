import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simplecashier/view/utils/utils.dart';

class ImageController{
  imagePicker({required ImageSource source,required BuildContext context})async{
  final  imagePickers= await ImagePicker().pickImage(source: source);
  if (imagePickers!=null) {
    return File(imagePickers.path);
  }
  else{
    return flushBarErrorMessage('Please select image', context);
  }

 }
}