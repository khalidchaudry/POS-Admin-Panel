import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:simplecashier/view/utils/constants.dart';
import 'package:uuid/uuid.dart';
import '../view/utils/utils.dart';
class UploadProductController{
      final String uuid=const Uuid().v4();

  // Upload Product Image on Firebase Storage
  firebaseStorage({required File image})async{
 final Reference reference = storage .ref('/Products/${DateTime.now().toString()}');
        final UploadTask uploadTask= reference.putFile(image);
        TaskSnapshot snapshot=await uploadTask;
        final String downloadUrl=await snapshot.ref.getDownloadURL();
        return downloadUrl;
  }
  // Upload Invoice to firebase Storage
  invoiceFirebaseStorage({required Uint8List image,required String productName})async{
 final Reference reference = storage .ref('/Invoices/${productName+DateTime.now().toString()}');
        final UploadTask uploadTask= reference.putData(image);
        TaskSnapshot snapshot=await uploadTask;
        final String downloadUrl=await snapshot.ref.getDownloadURL();
        return downloadUrl;
  }
  // Upload Product Data to Firestore

  fireStore ({required String productName,required productPrice,required productDesc,required productBarcode,required File? file})async{
    try {
      final String imageUrl=await firebaseStorage(image: file!);
     await firestore.collection('products').doc(uuid).set({
      'ProductName':productName,
      'ProductPrice':double.parse(productPrice),
      'ProductDesc':productDesc,
      'ProductBarcode':int.parse(productBarcode),
      'ProductImage':imageUrl,
      'id':uuid
    });
    Fluttertoast.showToast(msg: 'Uploaded Data Successfully',backgroundColor:Colors.purple);
    } catch (e) {
      return  Fluttertoast.showToast(msg: e.toString(),
      backgroundColor: AppColor.appBarBgColor
      );
    }
  }
  // Update Firestore Data
updateFireStore ({required String productName,required productPrice,
  required productDesc,required productBarcode,required File? file,required String id})async{
    try {
      final String imageUrl=await firebaseStorage(image: file!);
     await firestore.collection('products').doc(id.toString()).update({
      'ProductName':productName,
      'ProductPrice':double.parse(productPrice),
      'ProductDesc':productDesc,
      'ProductBarcode':int.parse(productBarcode).toInt(),
      'ProductImage':imageUrl,
    });
    Fluttertoast.showToast(msg: 'Updated Successfully',backgroundColor:Colors.purple);
    } catch (e) {
      return  Fluttertoast.showToast(msg: e.toString(),
      backgroundColor: AppColor.appBarBgColor
      );
    }
  }
  // Upload Invoice to Firestore
   invoiceFireStore ({required String productName,required Uint8List file,required String id})async{
    try {
      final String imageUrl=await invoiceFirebaseStorage(image: file, productName: productName);
     await firestore.collection('products').doc(id).update({
      'ProductName':productName,
      'InvoiceDateTime':DateTime.now().toString(),
      'ProductInvoice':imageUrl,
    });
    Fluttertoast.showToast(msg: 'Invoice saved Successfully',
    backgroundColor:Colors.purple
    );
    } catch (e) {
      return  Fluttertoast.showToast(msg: e.toString(),
      backgroundColor: AppColor.appBarBgColor
      );
    }
  }
}