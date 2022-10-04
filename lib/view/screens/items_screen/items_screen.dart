
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simplecashier/view/screens/items_screen/widgets/edit_items_details_widget.dart';
import 'package:simplecashier/view/utils/app_colors.dart';
import 'package:simplecashier/view/utils/constants.dart';

import '../../global_widegts/global_widgets.dart';

class ItemsScreen extends StatelessWidget {
   ItemsScreen({super.key});
     final fireStoreSnapshot =firestore.collection('products').snapshots();
  @override
  Widget build(BuildContext context) =>OrientationBuilder(builder: (context, orientation) {
    final isPortrait=orientation==Orientation.portrait;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Items'),
        backgroundColor: AppColor.appBarBgColor,
        actions: [IconButton(onPressed: (){
          showSearch(context: context, delegate: SearchDelegateWidget());
        }, icon: const Icon(Icons.search))],
      ),
      body: StreamBuilder<QuerySnapshot>(
        
        stream: fireStoreSnapshot,
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
          gridDelegate:   SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isPortrait?3:4,
                  mainAxisExtent: isPortrait?MediaQuery.of(context).size.height*.24:MediaQuery.of(context).size.height*.56,
           
          ),
          itemCount:snapshot.data!.docs.length,
          
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: (){ final  data=snapshot.data!.docs[index];
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>EditItemsScreen(
                                
                                id: data['id'],
                                image:data['ProductImage'].toString()
                                ,productName: data['ProductName'], desc: data['ProductDesc'], productPrice: data['ProductPrice'],barcode: data['ProductBarcode'])));},
                child: Container(
                  
                decoration: BoxDecoration(
              
                                border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.2)),
                                color: Colors.white,
                                boxShadow: [BoxShadow(
                                offset: const Offset(-2, 2),
                                blurRadius: 5,
                                color: Colors.grey.withOpacity(.5)
                                )],
                                borderRadius: BorderRadius.circular(15),
                      ),
                          child:  Column(children:  [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                              child: Image.network(snapshot.data!.docs[index]['ProductImage'],
                               width: isPortrait?MediaQuery.of(context).size.width*.4:MediaQuery.of(context).size.width*.5
                                       ,
                                          height: isPortrait?MediaQuery.of(context).size.height*.15:MediaQuery.of(context).size.height*.4
                                          ,
                                  fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 8,),
                            Text(snapshot.data!.docs[index]['ProductName'],textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                          ],)),
              ),
                        
            );
            
            });
          }
          else {
            return const Center(child: CircularProgressIndicator(backgroundColor: AppColor.appBarBgColor,));
          }
        
      }),
    );
  });
}