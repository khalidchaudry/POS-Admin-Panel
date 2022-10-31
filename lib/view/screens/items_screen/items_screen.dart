
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
                  
                  },isCheck: showList,color: AppColor.bgColor, width:40, height: 40, radius: 10, child: const Icon(Icons.menu),
                    ),    
           ],),
         )
        ],
      ),
      body:  StreamBuilder<QuerySnapshot>(
        stream: itemsDB,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return showList? ListView.builder(
              
              itemCount:snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
      
                final listData=snapshot.data!.docs[index];
               
                return ListTile(
                  enabled: true,
                  dense: true,
                  onLongPress: () => uploadController.deleteItems( id: listData['id']),
                  onTap: (){
      
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>EditItemsScreen(
                                  discount: listData['discount'],
                                  id: listData['id'],
                                  image:listData['ProductImage']
                                  ,productName: listData['ProductName'], desc: listData['ProductDesc'],
                                   productPrice: listData['ProductPrice'],barcode: listData['ProductBarcode'],)
                                   ));
                  },
                  title: Text(listData['ProductName'],style: const TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Text('Price:${listData['ProductPrice'].toString()}'),
                            
                  leading:CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(listData['ProductImage'],
                  
                    ),
                    ) ,);
                
                })
      :GridView.builder(
          gridDelegate:   SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isPortrait?3:4,
                  mainAxisExtent: isPortrait?customSize.height*.24:customSize.height*.56,
          ),
          itemCount:snapshot.data!.docs.length,
          itemBuilder: (BuildContext context, int index) {
            final gridData=snapshot.data!.docs[index];
            bool imageCheck=false;
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: NeumorphicButtonWidget(color: Colors.transparent,
              isCheck: imageCheck,
              press: (){
                setState(() {
                  imageCheck=!imageCheck;
                });
    Navigator.push(context, MaterialPageRoute(builder: (context)=>EditItemsScreen(
                                  discount: gridData['discount'],
                                  id: gridData['id'],
                                  image:gridData['ProductImage']
                                  ,productName: gridData['ProductName'], desc: gridData['ProductDesc'],
                                   productPrice: gridData['ProductPrice'],barcode: gridData['ProductBarcode'],)
                                   ));
                
              },
              child: TextButton(onPressed: (){},
                              onLongPress: () => uploadController.deleteItems( id: gridData['id']),
                child: Column(children: [
                  FadeInImage.assetNetwork(                 
                    width: double.infinity,
                     height: customSize.height*.1,
                          fit: BoxFit.cover,
                          placeholder: Images.loadingImage,
                          image: gridData['ProductImage'],
                          imageErrorBuilder: (c, o, s) => Image.asset(Images.loadingImage, fit: BoxFit.cover,),
                        ),
                  Text(gridData['ProductName'],),
                  Text(gridData['ProductPrice'].toString()),
                ],),
              ),
              )
                        
            );
            
            });
          }else{
            return const Center(child: CircularProgressIndicator.adaptive(backgroundColor: Colors.green,),);
          }
            })

    );
    // :const NoProductWidget(image: Images.noData);
  });
}