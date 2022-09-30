import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class ReceiptDetailWidget extends StatelessWidget {
  const ReceiptDetailWidget({super.key, required this.image});
final String image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Receipt Details'),
      elevation: 0,
      toolbarHeight: 65,
      backgroundColor: AppColor.appBarBgColor,
      ),
      body: Container(decoration: BoxDecoration(
        
        image:DecorationImage(image: NetworkImage(image),) ),)
    );
  }
}