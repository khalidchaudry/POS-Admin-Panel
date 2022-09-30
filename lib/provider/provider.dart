import 'package:flutter/cupertino.dart';

class ValueProvider with ChangeNotifier{
  double total=0;
  int items=0;
   int quantity=0;
 valueUpdate(){
   double total=0;
  int items=0;
   int quantity=0;
   notifyListeners();
 }
}