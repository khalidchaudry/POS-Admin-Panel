import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';
import 'global_widgets.dart';

class ListTileWidget extends StatelessWidget {
  final bool isCheck;
  final String image;
  final String id;
  final String productName;
  final String companyName;
  final String companyName2;
  final String productName2;
  final String stockQuantity;
  final dynamic stockQuantity2;
  final Function() press;
  const ListTileWidget({super.key, required this.image, required this.productName, required this.companyName,
   required this.stockQuantity, required this.press, required this.isCheck, required this.id, required this.companyName2, required this.productName2, required this.stockQuantity2});
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: NeumorphicButtonWidget(
          isCheck:isCheck ,
          color: Colors.transparent,
          press:press,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: size.width*.3,
                    height: size.height*.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(image: NetworkImage(image),
                      onError: (exception, stackTrace) => Image.asset(Images.loadingImage),
                      fit: BoxFit.cover
                      )),
                  ),
                  SizedBox(width: size.width*.02,),
                  Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                    children: [                      
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                        RowTextWidget(text1: productName, text2: productName2, text1Bold: const TextStyle(fontWeight: FontWeight.bold), text2Bold:  const TextStyle(fontWeight: FontWeight.normal)),
                         SizedBox(width: size.width*.01,),
                         TextButton(onPressed: (){
                          inventoryController.deleteItems(id: id);
                          log( '************This $id product Deleted************');
                         }, child:  const Icon(CupertinoIcons.trash,color: Colors.red,))
                       ],
                     ),
                     SizedBox(height:size.height*.01),
                    RowTextWidget(text1: stockQuantity, text2: stockQuantity2.toString(), text1Bold: const TextStyle(fontWeight: FontWeight.bold), text2Bold:  const TextStyle(fontWeight: FontWeight.normal)),
                    SizedBox(height:size.height*.01),
                    RowTextWidget(text1: companyName, text2: companyName2.toString(), text1Bold: const TextStyle(fontWeight: FontWeight.bold), text2Bold:  const TextStyle(fontWeight: FontWeight.normal)),                   
                  ],),
                ],
              ),
          
        ),
    );
  }
}