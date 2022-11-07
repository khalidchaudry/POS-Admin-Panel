import 'package:cloud_firestore/cloud_firestore.dart';

class Cart {
  String? productImage;
  double? productPrice;
  int? quantity;
  String? productName;
  String? cartId;
  Cart({
    this.productImage,
    this.productPrice,
    this.quantity,
    this.productName,
    this.cartId
   
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        productImage:
            json["productImage"],
        productPrice:
            json["productPrice"],
        productName: json["productName"],
        cartId: json["cartId"],
        quantity:
            json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "productImage": productImage,
        "productPrice": productPrice,
        "productName": productName,
        "cartId": cartId,
        "quantity": quantity,
      };

  factory Cart.fromDocument(QueryDocumentSnapshot doc) {
    return Cart(
      productImage: doc["productImage"],
      productPrice: doc["productPrice"],
      quantity: doc["quantit"],
      productName: doc["productNam"],
      cartId: doc["cartId"],
    );
  }

  Cart.fromMap(Map<String, dynamic> data) {
    productImage = data['productImage'];
    productPrice = data['productPrice'];
    quantity = data['quantity'];
    productName = data['productName'];
    cartId = data['cardId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'productImage': productImage,
      'productPrice': productPrice,
      'quantity': quantity,
      'productName': productName,
      'cartId': cartId,
    };
  }
}
