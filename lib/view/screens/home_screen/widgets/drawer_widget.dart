import 'package:flutter/material.dart';
import 'package:simplecashier/view/screens/add_items_screen/add_items_screen.dart';

import '../../../utils/images.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(children:  [
          Container(
            padding: const EdgeInsets.all(15),
            alignment: Alignment.centerLeft,
            width: double.infinity,
            height: 200,color: Colors.green,child:const  Text('Simple\nCashier',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),),
          listTileWidget(
            image: Images.addItem,
            title: 'Add Item',
            press: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=> const AddItemsScreen()))
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