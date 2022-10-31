

class ReceiptModel{
  late  String invoiceImage, invoiceId;
  ReceiptModel({required this.invoiceImage,required this.invoiceId});

  ReceiptModel.fromJson(Map<String,dynamic> map){
    invoiceImage=map['invoiceImage'];
    invoiceId=map['invoiceId'];
  }

  // ReceiptModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
  //   invoiceImage = documentSnapshot["invoiceImage"];
  //   invoiceId = documentSnapshot["invoiceId"];
  //     }
}