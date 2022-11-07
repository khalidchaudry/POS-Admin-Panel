
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../global_widgets/global_widgets.dart';
import '../../utils/utils.dart';
import 'widgets/widget.dart';

class ItemsScreen extends StatefulWidget {
   const ItemsScreen({super.key});

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  final itemsDB=firestore.collection('products').snapshots();
bool showList=false;
  @override
  Widget build(BuildContext context) =>OrientationBuilder(builder: (context, orientation) {
           var customSize=MediaQuery.of(context).size;
    final isPortrait=orientation==Orientation.portrait;
    bool searchData=false;

    return Scaffold(
      appBar: AppBar(
  
        centerTitle: true,
        elevation: 0,
        title: const Text('Items',style: AppColor.appBarTextStyle),
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
          bool isCheck=false;
          if (snapshot.hasData) {
            return showList? snapshot.data!.docs.isNotEmpty?ListView.builder(
              
              itemCount:snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
      
                final listData=snapshot.data!.docs[index];
               
                return ListTileWidget(image: listData['ProductImage'], productName: 'Name: ', companyName: 'Desc: ', stockQuantity: 'Price: ',
                 press: (){
                  setState(() {
                    isCheck=!isCheck;
                  });
                 }, isCheck: isCheck, id: listData['id'], companyName2: listData['ProductDesc'], productName2: listData['ProductName'], stockQuantity2: listData['ProductPrice'].toString());
                
                }):Center(child: Image.asset(Images.noInternet),)
      :snapshot.data!.docs.isNotEmpty?GridView.builder(
          gridDelegate:   SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isPortrait?3:5,
                  mainAxisExtent: isPortrait?customSize.height*.24:customSize.height*.56,
          ),
          itemCount:snapshot.data!.docs.length,
          itemBuilder: (BuildContext context, int index) {
            final gridData=snapshot.data!.docs[index];
            return GridViewWidget(press: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>EditItemsScreen(
                                  discount: gridData['discount'],
                                  id: gridData['id'],
                                  image:gridData['ProductImage']
                                  ,productName: gridData['ProductName'], desc: gridData['ProductDesc'],
                                   productPrice: gridData['ProductPrice'])
                                   )),

              longPress:() => uploadController.deleteItems( id: gridData['id']), 
              desc: gridData['ProductDesc'],
              image: gridData['ProductImage'], name: gridData['ProductName'], price: gridData['ProductPrice']);
            
            }):Center(child: Image.asset(Images.noInternet),);
          }else{
            return const Center(child: CircularProgressIndicator.adaptive(backgroundColor: Colors.green,),);
          }
            })

    );
    // :const NoProductWidget(image: Images.noData);
  });
}