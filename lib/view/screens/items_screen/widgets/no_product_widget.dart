import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class NoProductWidget extends StatelessWidget {
  const NoProductWidget({super.key});

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Items'),
        backgroundColor: AppColor.appBarBgColor,
        actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.search))],
      ),
      body: SafeArea(child: Padding(padding: const EdgeInsets.all(20),
      child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                             children:  [
                              Image.asset(Images.noProduct,width: 200),
                              const SizedBox(height: 10,),
                              const Text('No Products',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.grey),),
                             ],
                           ),
      )),
    );
  }
}