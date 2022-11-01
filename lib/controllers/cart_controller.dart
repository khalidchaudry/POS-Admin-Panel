import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../view/utils/utils.dart';

class CartController{
  // Add to cart
  addCart({required String productName,productImage,required double productPrice,required int quantity})async{
            final String cartId=const Uuid().v4();
      try {
        await firestore.collection('cart').doc(cartId).set({
            'productName':productName,
            'productPrice':double.parse(productPrice.toString()),
            'productImage':productImage,
            'cartId':cartId,
            'quantity':quantity,
          });
          fluttertoast(message: 'Add to cart successfully');
      } catch (e) {
                  fluttertoast(message: e.toString());
      }        
    }
    // Delete Items 
  deleteItems({required String cartID})async{
    try {
        await firestore.collection('cart').doc(cartID).delete();         
          fluttertoast(message: 'Deleted Successfully...');
          debugPrint('Cart ID:$cartID');
    } catch (e) {
fluttertoast(message: e.toString());    }
  }
  // Update Cart Data
   updateCart({required int quantity,required String updateId})async{
      try {
        await firestore.collection('cart').doc(updateId).update({
            'quantity':int.parse(quantity.toString()),
            // 'productPrice':double.parse(productPrice.toString()),
          });
          fluttertoast(message: 'Cart Updated');
      } catch (e) {
                  fluttertoast(message: e.toString());
      }        
    }
}