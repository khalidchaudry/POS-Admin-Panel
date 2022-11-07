
class CartModel {
   String? productImage;
   double? productPrice;
   int ? productQuantiy;
   String? productName;
   String? productId;
  CartModel({
   required this.productImage,
   required this.productPrice,
   required this.productQuantiy,
   required this.productName,
   required this.productId,
  });
  
 static CartModel fromJson(Map<String, dynamic> map)=>CartModel(
    productId : map['productId'],
    productName : map['productName'],
    productImage : map['productImage'],
    productPrice : map['productPrice'],
    productQuantiy:map['productQuantiy']
  );

  // factory CartModel.fromFirestore(DocumentSnapshot doc) {
  //   Map data = doc.data as Map;
  //   return CartModel(
  //     productId: doc.id,
  //     productName: data['productName'] ?? '',
  //     productImage: data['productImage'] ?? '',
  //     productPrice: data['productPrice'] ?? 0.00,
  //     productQuantiy: data['quantity']??0
  //   );
  // }
}