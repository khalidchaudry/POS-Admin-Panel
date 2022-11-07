
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:simplecashier/view/utils/firebase.dart';

import '../model/cart.dart';


class CartProvider with ChangeNotifier {
  List<Cart> cartList = [];

  final List<Cart> _ahmedCartList = [];
  Cart? cartModel;

  String? totalPriceOfOARDER;

  List<Cart> get getAhmedCartlist => _ahmedCartList;

  List<Cart> get getCartList {
    return cartList;
  }

  subTotalAhmed() {
    int subTotal = 0;

    for (var element in _ahmedCartList) {
      subTotal += element.productPrice!.toInt() * element.quantity!;
      totalPriceOfOARDER = subTotal.toString();
    }
    return subTotal;
  }

  addToCart(Cart paramsCartModel) {
    _ahmedCartList.add(paramsCartModel);
    notifyListeners();
  }
getData()async{
QuerySnapshot document=await firestore.collection('cart').get();
for (var element in document.docs) { 
  Cart cart=Cart(
    productName: element.get('productName'),
    productImage: element.get('productImage'),
    productPrice: element.get('productPrice'),
    quantity: element.get('quantity'),
    cartId: element.get('cartId')
  );
      _ahmedCartList.add(cart);
}
}
  clearAllOrdersAndSessions() {
    _ahmedCartList.clear();
    notifyListeners();
  }
  void removeItemFromCart(String productId) {
    debugPrint("REmove Item Method");
    int index =
        _ahmedCartList.indexWhere((element) => element.cartId == productId);
    debugPrint("Product index $index");
    debugPrint("Before Remove Length ${_ahmedCartList.length}");
    _ahmedCartList.removeAt(index);
    debugPrint("After Remove Length ${_ahmedCartList.length}");
    notifyListeners();
  }
}
