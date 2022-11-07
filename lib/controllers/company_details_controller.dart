
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../view/utils/utils.dart';

class CompanyDetailsController{
  // Upload Product Image on Firebase Storage
  firebaseStorage({required Uint8List image})async{
 final Reference reference = storage .ref('/Company Logo/${DateTime.now().toString()}');
        final UploadTask uploadTask= reference.putData(image);
        TaskSnapshot snapshot=await uploadTask;
        final String downloadUrl=await snapshot.ref.getDownloadURL();
        return downloadUrl;
  }
  // Upload Company Data to Firestore
  companyData ({required String userName,required companyName,required licenseNumber,required address,required Uint8List? file})async{
    try {
      final String imageUrl=await firebaseStorage(image: file!);
     await firestore.collection('companyInfo').doc(uuid).set({
     'userName':userName,
      'companyName':companyName,
      'licenseNumber':licenseNumber,
      'address':address,
      'companyLogo':imageUrl,
      'id':uuid
    });
    Fluttertoast.showToast(msg: 'Your Credential Saved Successfully',backgroundColor:Colors.purple);
    } catch (e) {
            debugPrint(e.toString());

      return  Fluttertoast.showToast(msg: e.toString(),
      backgroundColor: AppColor.navigationRailBgColor,
      );
    }
  }
}