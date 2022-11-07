import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../global_widgets/global_widgets.dart';
import '../../routes/route_name.dart';
import '../../utils/utils.dart';
import 'widgets/edit_inventory_items_widget.dart';

class InventoryScreen extends StatefulWidget {
   const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final itemsDB=firestore.collection('inventory').snapshots();
bool showList=false;
  @override
  Widget build(BuildContext context) =>OrientationBuilder(builder: (context, orientation) {
           var customSize=MediaQuery.of(context).size;
    final isPortrait=orientation==Orientation.portrait;
    bool searchData=false;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Inventory',
        onPressed: ()=>Navigator.pushNamed(context, RouteName.addInventory),
        child: const Icon(Icons.add)),
      appBar: AppBar(
  
        centerTitle: true,
        elevation: 0,
        title: const Text(AppString.inventory,style: AppColor.appBarTextStyle),
        backgroundColor: AppColor.appBarBgColor,
        actions: [
         Padding(
           padding: const EdgeInsets.all(10.0),
           child: Row(children: [
             NeumorphismButtonWidget(  press: (){
                    setState(() {
                      searchData=!searchData;
                    });
                    showSearch(context: context, delegate: SearchDelegateWidget());
                  },isCheck: searchData,color: AppColor.bgColor, width:40, height: 40, radius: 10, child: const Icon(Icons.search),
                    ),
                    const SizedBox(width: 20,),
                NeumorphismButtonWidget(  press: (){
                    setState(() {
                      showList=!showList;
                    });
                  
                  },isCheck: showList,color: AppColor.bgColor, width:40, height: 40, radius: 10, child:  showList==false?Image.asset(Images.list):Image.asset(Images.menu),
                    ),    
           ],),
         )
        ],
      ),
      body:  StreamBuilder<QuerySnapshot>(
        stream: itemsDB,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return showList? snapshot.data!.docs.isNotEmpty?ListView.builder(             
              itemCount:snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                final listData=snapshot.data!.docs[index];
               bool isCheck=false;
                return ListTileWidget(image: listData['stockImage'], productName2: listData['ProductName'], 
                companyName2: listData['companyName'],
                productName: 'Name: ',
                companyName: 'Company: ',
                stockQuantity: 'Stock: ',
                 stockQuantity2: listData['stockQuantity'], press: (){
                  setState(() {
                    isCheck=!isCheck;
                  });
                 }, isCheck: isCheck, id: listData['id']);
                
                }):Center(child: Image.asset(Images.noInternet),)
      :snapshot.data!.docs.isNotEmpty?GridView.builder(
          gridDelegate:   SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isPortrait?3:4,
                  mainAxisExtent: isPortrait?customSize.height*.24:customSize.height*.56,
          ),
          itemCount:snapshot.data!.docs.length,
          itemBuilder: (BuildContext context, int index) {
            final gridData=snapshot.data!.docs[index];
            return GridViewWidget(press: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>EditInventoryItemsScreen(
                                  id: gridData['id'],
                                  image:gridData['stockImage']
                                  ,productName: gridData['ProductName'], companyName: gridData['companyName'],
                                   stock: gridData['stockQuantity'])
                                   )), 

                                   longPress: ()=>uploadController.deleteItems( id: gridData['id']), 
                                   image: gridData['stockImage'], desc: '',name: gridData['ProductName'], price: gridData['stockQuantity']);
            }):Center(child: Image.asset(Images.noInternet),);
          }else{
            return const Center(child: CircularProgressIndicator.adaptive(backgroundColor: Colors.green,),);
          }
            })

    );
  });
}