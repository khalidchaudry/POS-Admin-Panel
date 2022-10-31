import 'package:cloud_firestore/cloud_firestore.dart';
class CartModel {
  String? productImage;
  double? productPrice;
  int? productQuantiy;
  String? productName;
  String? productId;

  CartModel({
    this.productImage,
    this.productPrice,
    this.productQuantiy,
    this.productName,
    this.productId,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        productImage:
            json["productImage"],
        productPrice:
            json["productPrice"],
        productName: json["productName"],
       
        productId: json["productId"],
        productQuantiy:
            json["productQuantiy"],
    
      );

  Map<String, dynamic> toJson() => {
        "productImage": productImage,
        "productPrice": productPrice,
        "productName": productName,
        "productId": productId,
        "productQuantiy": productQuantiy,
      };

  factory CartModel.fromDocument(QueryDocumentSnapshot doc) {
    return CartModel(
      productImage: doc["productImage"],
      productPrice: doc["productPrice"],
      productQuantiy: doc["productQuantiy"],
      productName: doc["productName"],
      productId: doc["productId"],
    );
  }

  CartModel.fromMap(Map<String, dynamic> data) {
    productImage = data['productImage'];
    productPrice = data['productPrice'];
    productQuantiy = data['productQuantiy'];
    productName = data['productName'];
    productId = data['productId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'productImage': productImage,
      'productPrice': productPrice,
      'productQuantiy': productQuantiy,
      'productName': productName,
      'productId': productId,
    };
  }
}
