import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:simplecashier/controllers/upload_product_controller.dart';
// Firebase Auth
 FirebaseAuth auth=FirebaseAuth.instance;
 // Firebase Storage
 FirebaseStorage storage=FirebaseStorage.instance;
 // Firebase Cloud FireStore
 FirebaseFirestore firestore=FirebaseFirestore.instance;
 // Upload Products Controller Class
 UploadProductController controller=UploadProductController(); 

  