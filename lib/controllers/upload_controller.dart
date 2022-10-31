import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../view/utils/utils.dart';

class UploadController{
  // Upload Product Image on Firebase Storage
  firebaseStorage({required File image})async{
 final Reference reference = storage .ref('/Products/${DateTime.now().toString()}');
        final UploadTask uploadTask= reference.putFile(image);
        TaskSnapshot snapshot=await uploadTask;
        final String downloadUrl=await snapshot.ref.getDownloadURL();
        return downloadUrl;
  }
  // Upload Product Data to Firestore

  fireStore ({required String productName,required productDiscount,required productPrice,required productDesc,required productBarcode,required File? file})async{
    try {
      final String imageUrl=await firebaseStorage(image: file!);
     await firestore.collection('users').doc(auth.currentUser!.uid).collection('products').doc(uuid).set({
     'ProductName':productName,
      'ProductPrice':double.parse(productPrice),
      'discount':double.parse(productDiscount),
      'ProductDesc':productDesc,
      'ProductBarcode':productBarcode,
      'ProductImage':imageUrl,
      'id':uuid
    });
    Fluttertoast.showToast(msg: 'Upload Data Successfully',backgroundColor:Colors.purple);
    } catch (e) {
            debugPrint(e.toString());

      return  Fluttertoast.showToast(msg: e.toString(),
      backgroundColor: AppColor.navigationRailBgColor,
      );
    }
  }
  // Update Firestore Data
updateFireStore ({required String productName,required productPrice,required productDiscount,
  required productDesc,required productBarcode,required  id,required File? file,})async{
    try {
      final String imageUrl=await firebaseStorage(image: file!);
     await firestore.collection('products').doc(id.toString()).update({
      'ProductName':productName,
      'ProductPrice':double.parse(productPrice),
      'ProductDesc':productDesc,
      'discount':double.parse(productDiscount),
      'ProductBarcode':productBarcode,
      'ProductImage':imageUrl,
    });
    Fluttertoast.showToast(msg: 'Updated Successfully',backgroundColor:Colors.purple);
    } catch (e) {
      return  Fluttertoast.showToast(msg: e.toString(),
      backgroundColor: Colors.purple
      );
    }
  }
  
  // Delete Items 
  deleteItems({required String   id})async{
    try {
          firestore.collection('products').doc(id).delete();         
          fluttertoast(message: 'Deleted Successfully...');
    } catch (e) {
fluttertoast(message: e.toString());    }
  }
}