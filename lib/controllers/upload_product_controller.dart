import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:simplecashier/view/utils/constants.dart';
import 'package:uuid/uuid.dart';
import '../view/utils/utils.dart';
class UploadProductController{
      final String uuid=const Uuid().v4();

  // Upload Product Image on Firebase Storage
  firebaseStorage({required File image})async{
 final Reference reference = storage .ref('/Products/${DateTime.now().toString()}');
        final UploadTask uploadTask= reference.putFile(image);
        TaskSnapshot snapshot=await uploadTask;
        final String downloadUrl=await snapshot.ref.getDownloadURL();
        return downloadUrl;
  }
  // Upload Product Data to Firestore

  fireStore ({required String productName,required productPrice,required productDesc,required productBarcode,required File? file})async{
    try {
      final String imageUrl=await firebaseStorage(image: file!);
     await firestore.collection('products').doc(uuid).set({
      'ProductName':productName,
      'ProductPrice':productPrice,
      'ProductDesc':productDesc,
      'ProductBarcode':productBarcode,
      'ProductImage':imageUrl
    });
    Fluttertoast.showToast(msg: 'Uploaded Data Successfully',
    
      );
    } catch (e) {
      return  Fluttertoast.showToast(msg: e.toString(),
      backgroundColor: AppColor.appBarBgColor
      );
     
    }
    

  }
}