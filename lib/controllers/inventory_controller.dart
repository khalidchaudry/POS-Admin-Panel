import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../view/utils/utils.dart';

class InventoryController{
  // Upload Product Image on Firebase Storage
  firebaseStorage({required File image})async{
 final Reference reference = storage .ref('/Stock/${DateTime.now().toString()}');
        final UploadTask uploadTask= reference.putFile(image);
        TaskSnapshot snapshot=await uploadTask;
        final String downloadUrl=await snapshot.ref.getDownloadURL();
        return downloadUrl;
  }
  // Upload Product Data to Firestore
  stock ({required String productName,required stock,required companyName,required File? file})async{
    try {
      final String imageUrl=await firebaseStorage(image: file!);
     await firestore.collection('inventory').doc(uuid).set({
     'ProductName':productName,
      'stockQuantity':int.parse(stock),
      'companyName':companyName,
      'stockImage':imageUrl,
      'id':uuid
    });
    Fluttertoast.showToast(msg: 'Stock Data Saved Successfully',backgroundColor:Colors.purple);
    } catch (e) {
            debugPrint(e.toString());

      return  Fluttertoast.showToast(msg: e.toString(),
      backgroundColor: AppColor.navigationRailBgColor,
      );
    }
  }
  // Update Firestore Data
updateStock ({required String productName,required stock,
  required companyName,required  id,required File? file,})async{
    try {
      final String imageUrl=await firebaseStorage(image: file!);
     await firestore.collection('inventory').doc(id.toString()).update({
      'ProductName':productName,
      'stockQuantity':double.parse(stock),
      'companyName':companyName,
      'stockImage':imageUrl,
    });
    Fluttertoast.showToast(msg: 'Stock Data Updated',backgroundColor:Colors.purple);
    } catch (e) {
      return  Fluttertoast.showToast(msg: e.toString(),
      backgroundColor: Colors.purple
      );
    }
  }
  
  // Delete Items 
  deleteItems({required String   id})async{
    try {
          firestore.collection('inventory').doc(id).delete();         
          fluttertoast(message: 'Deleted Successfully...');
    } catch (e) {
fluttertoast(message: e.toString());    }
  }
}