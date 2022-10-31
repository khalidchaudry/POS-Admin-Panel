class ProductModel {
  final String productName;
  final String productImage;
  final String id;
  final String productBarcode;
    final String productDesc;
  final double price;
   final double discount;
  ProductModel({
    required this.productName,
   required this.productImage,
   required this.id,
   required this.price,
   required this.discount,
   required this.productBarcode,
   required this.productDesc
  });
  
}
