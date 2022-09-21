import 'package:flutter/material.dart';

import '../../../utils/images.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(children:  [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 200,color: Colors.green,child:const  Text('Simple Cashier',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),),
          listTileWidget(
            image: Images.addItem,
            title: 'Add Item',
            press: (){}
          ),
           listTileWidget(
            image: Images.items,
            title: 'Items',
            press: (){}
          ),
           listTileWidget(
            image: Images.receipts,
            title: 'Receipts',
            press: (){}
          ),
           listTileWidget(
            image: Images.about,
            title: 'About',
            press: (){}
          ),
        ],),
      ),
    );
  }
  ListTile listTileWidget({required String title,required String image,required Function() press}) {
    return  ListTile(
      leading: Image.asset( image,width: 40,height: 40,),
      title: Text(title),
      onTap: press,
    );
  }
}