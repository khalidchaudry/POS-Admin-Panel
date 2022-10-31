import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

import '../view/utils/utils.dart';

class InvoiceController{
  // Upload Invoice to firebase Storage
  invoiceFirebaseStorage({required Uint8List image})async{
 final Reference reference = storage .ref('/Invoices/${DateTime.now().toString()}');
        final UploadTask uploadTask= reference.putData(image);
        TaskSnapshot snapshot=await uploadTask;
        final String downloadUrl=await snapshot.ref.getDownloadURL();
        return downloadUrl;
  }

  invoiceFireStore ({required Uint8List invoiceImage})async{
    try {
      final invoiceId=const Uuid().v1();
      final String imageUrl=await invoiceFirebaseStorage(image: invoiceImage);
     await firestore.collection('users').doc(auth.currentUser!.uid).collection('invoices').doc(invoiceId).set({
      'ProductInvoice':imageUrl,
      'invoiceId':invoiceId,
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