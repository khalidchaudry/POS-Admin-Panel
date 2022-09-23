import 'package:flutter/material.dart';
import 'package:simplecashier/view/screens/home_screen/widgets/bottom_widget.dart';
import 'package:simplecashier/view/screens/home_screen/widgets/drawer_widget.dart';

import '../../utils/utils.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
        // bottomSheet: const BottomWidget(),
        drawer: const DrawerWidget(),
        appBar: AppBar(title: const Text(AppString.appName),elevation: 0,backgroundColor: AppColor.appBarBgColor),
        body: SafeArea(child: Column(children:   [
          Container(
          width: double.infinity,
          color: AppColor.appBarBgColor,
          child:   const TabBar(
            indicatorColor: Colors.white,
            tabs: [Tab(text: 'ITEM',),
          Tab(text: 'CART',)
          ]),
          ),
            SizedBox(
            height: MediaQuery.of(context).size.height*.65,
             child: TabBarView(children: [
              
                           Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                             children:  [
                              Image.asset(Images.noProduct,width: 200),
                              const SizedBox(height: 10,),
                              const Text('No Products',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.grey),),
                             ],
                           ),

Column(
  mainAxisAlignment: MainAxisAlignment.center,
  
                             children:  [
                         
                              Image.asset(Images.cart,width: 200,color: Colors.red,),
                              const SizedBox(height: 10,),
                              const Text('Empty Cart',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.grey),),
                            
                             
                             ],
                           ),           
                     ]),
           ),
                                       BottomWidget(),

        ],)),
      ),
      
    );
  }
}