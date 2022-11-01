import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../global_widgets/global_widgets.dart';
import '../../utils/utils.dart';
import '../invoice_screen/invoice_screen.dart';
class CartScreen extends StatefulWidget {
  // final String name;
  // final String image;
  // final int quantity;
  // final double price;
  // final String id;
  // const CartScreen({super.key, required this.name, required this.image, required this.quantity, required this.price, required this.id});
  @override
  State<CartScreen> createState() => _CartScreenState();
}
class _CartScreenState extends State<CartScreen> {
   final  cartStore=firestore.collection('cart').snapshots();
   TextEditingController quantityController=TextEditingController();
double price=0.00;
int quantity=1;
int length=0;
bool textValue=true;
 String itemName = '';
  String itemImage = ''; 
  String cartId='';
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
        return Scaffold(
       bottomNavigationBar: Padding(
         padding: const EdgeInsets.all(8.0),
         child: ListTile(
          title: const Text('Total'),
         subtitle: const Text('Price'),
         trailing:ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            backgroundColor: Colors.green),
          onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (_)=> InvoiceScreen(invoiceId: cartId,)));
         }, child: const Text('Make Invoice',style: TextStyle(color: Colors.white),)),
         ),
       ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.green),
        centerTitle: true,
        elevation: .5,
        title:   const Text('Cart',style: AppColor.appBarTextStyle,),
      backgroundColor: AppColor.appBarBgColor,
      actions: [IconButton(onPressed: (){
          showSearch(context: context, delegate: SearchDelegateWidget());
        }, icon: const Icon(Icons.search))],
      ),
      body:StreamBuilder<QuerySnapshot>(
        stream: cartStore,
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final data=snapshot.data!.docs[index];
              return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Container(
                            width: size.width*.3,
                            height: size.height*.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(image: NetworkImage(data['productImage'].toString()),
                              fit: BoxFit.cover
                              )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                              children: [                      
                               Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Text(data['productName'].toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                   TextButton(onPressed: (){
                                    cartController.deleteItems(cartID: data['cartId'].toString());
                                    log( '************This ${data['cartId']} product Deleted************');
                                   }, child:  const Icon(CupertinoIcons.delete_left,color: Colors.red,))
                                 ],
                               ),
                               SizedBox(height:size.height*.04),
                              textValue? Text(data['productPrice'].toString(),style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.blueGrey),):
                              Text((quantity*data['productPrice']).toStringAsFixed(2),style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.blueGrey),),
                              SizedBox(height:size.height*.02),
                               SizedBox(
                                width: size.width*.5,
                                height: 50,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: quantityController,
                                  decoration:   InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Quantity',
                                    border:  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                    suffixIcon: TextButton(onPressed: (){
                                      setState(() {
                                        quantity=int.parse(quantityController.text.toString());
                                        // price=(data['productPrice'])*int.parse(data['quantity'].toString());
                                  textValue=!textValue;
                             cartController.updateCart(updateId:  data['cartId'].toString(),quantity: int.parse(quantityController.text.toString()));
                             quantityController.clear();
                                  });
                                    }, child: const Text('ADD')
                                  ),
                                ),
                              )),
                           
                            ],),
                          ),
                        ],
                      ),
                    );
            });
          }else{
            return const Center(child: CircularProgressIndicator(),);
          }
          
        }
      ),
    );
  }

}