import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:simplecashier/model/receipt_model.dart';
import 'package:simplecashier/view/utils/firebase.dart';

class ReceiptController with ChangeNotifier{
    List<ReceiptModel> receiptModelList=[];
  Future<void> getReceiptData()async{
    await firestore.collection('users').doc(auth.currentUser!.uid).collection('invoices').get().then((value) {
      receiptModelList=value.docs.map((e) => ReceiptModel.fromJson(e.data())).toList();
      log(receiptModelList.toString());
    });
  }
}