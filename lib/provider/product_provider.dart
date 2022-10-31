
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/model.dart';
import '../view/utils/utils.dart';

class ProductProvider with ChangeNotifier{
 
  // get product Data
   List<ProductModel> getproductDataList=[];
  getProductData()async{
      List<ProductModel> removeDuplicationModel=[];
    QuerySnapshot getData=await firestore.collection('products').get();
   for (var element in getData.docs) { 
     ProductModel getProductData=ProductModel(
        productName: element.get('ProductName'), productImage: element.get('ProductImage'),
         productBarcode: element.get('ProductBarcode'), productDesc: element.get('ProductDesc'), 
         id: element.get('id'), price: element.get('ProductPrice'), discount: element.get('discount'),
         );
         removeDuplicationModel.add(getProductData);
   }
    getproductDataList=removeDuplicationModel;
    notifyListeners();
  }
}