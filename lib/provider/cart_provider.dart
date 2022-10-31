
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:simplecashier/view/utils/firebase.dart';

import '../model/model.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> cartList = [];
  final List<CartModel> _ahmedCartList = [];

  CartModel? cartModel;

  String? totalPriceOfOARDER;

  List<CartModel> get getAhmedCartlist => _ahmedCartList;


  subTotalAhmed() {
    int subTotal = 0;

    for (var element in _ahmedCartList) {
      subTotal += element.productPrice!.toInt() * element.productQuantiy!;
      totalPriceOfOARDER = subTotal.toString();
    }
    return subTotal;
  }

  // addToCart(CartModel paramsCartModel) {
  //   _ahmedCartList.add(paramsCartModel);
  //   notifyListeners();
  // }
getFromCart()async{
  List<CartModel> model=[];
  QuerySnapshot data=await firestore.collection('cart').get();
  for (var element in data.docs) { 
    CartModel modelData=CartModel(
      productName: element.get('productName'),
      productImage: element.get('productImage'),
      productPrice: element.get('productPrice'),
      productId: element.get('cartId'),
      productQuantiy: element.get('quantity')
    );
    _ahmedCartList.add(modelData);
  }
  
  cartList=model;
  print('Cart data: $cartList');
  notifyListeners();
}
  clearAllOrdersAndSessions() {
    _ahmedCartList.clear();
    notifyListeners();
  }

  void increaseQuantity(String productId) {
    debugPrint("Increase Method");
    int index =
        _ahmedCartList.indexWhere((element) => element.productId == productId);

    debugPrint("Product index $index");
    _ahmedCartList[index].productQuantiy =
        _ahmedCartList[index].productQuantiy! + 1;
    debugPrint("Product quantiy ${_ahmedCartList[index].productQuantiy}");
    notifyListeners();
  }

  void decreaseQuantity(String productId) {
    debugPrint("Decrease Method");
    int index =
        _ahmedCartList.indexWhere((element) => element.productId == productId);

    debugPrint("Product index $index");
    if (_ahmedCartList[index].productQuantiy! < 1) return;
    _ahmedCartList[index].productQuantiy =
        _ahmedCartList[index].productQuantiy! - 1;
    notifyListeners();
  }

  void removeItemFromCart(String productId) {
    debugPrint("REmove Item Method");
    int index =
        _ahmedCartList.indexWhere((element) => element.productId == productId);

    debugPrint("Product index $index");
    debugPrint("Before Remove Length ${_ahmedCartList.length}");

    _ahmedCartList.removeAt(index);
    debugPrint("After Remove Length ${_ahmedCartList.length}");
    notifyListeners();
  }
}
