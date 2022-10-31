import 'package:flutter/material.dart';

class RowTextWidget extends StatelessWidget {
  const RowTextWidget({super.key, required this.text1, required this.text2, required this.text1Bold, required this.text2Bold});
final String text1;
final String text2;
final TextStyle text1Bold;
final TextStyle text2Bold;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      Text(text1,style: text1Bold,),
      Text(text2,style: text2Bold,),
    ],);
  }
}