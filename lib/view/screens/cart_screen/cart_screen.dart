import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:simplecashier/provider/cart_provider.dart';
import '../../global_widgets/global_widgets.dart';
import '../../utils/utils.dart';
import '../invoice_screen/invoice_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}
class _CartScreenState extends State<CartScreen> {
   final  cartStore=firestore.collection('addToCart').snapshots();
   TextEditingController quantityController=TextEditingController();
double price=0.00;
int quantity=0;
int length=0;
bool textValue=true;
 String itemName = '';
  String itemImage = ''; 
  String cartId='';
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider=Provider.of<CartProvider>(context);
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
      body: StreamBuilder<QuerySnapshot>(
        stream: cartStore,
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var data=snapshot.data!.docs[index];
                 var size=MediaQuery.of(context).size;
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
                                cartController.deleteItems(cartID: data.id.toString());
                                debugPrint( data.id);
                               }, child:  const Icon(CupertinoIcons.delete_left,color: Colors.red,))
                             ],
                           ),
                           SizedBox(height:size.height*.04),
                          textValue? Text(data['productPrice'].toString(),style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.blueGrey),):
                          Text(('price').toString(),style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.blueGrey),),
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
                              cartId=data['cartId'];
                         cartController.updateCart(updateId:  data.id.toString(),quantity: quantity);
      
                         quantityController.clear();
                              });
                                }, child: const Text('ADD')
                              ),
                            ),
                          )),
                        //     Row(
                        //       children:  [
                        //       NeumorphicButtonWidget(isCheck: false, press: (){
                        //         setState(() {
                        //       quantity-=1;
                        //         price=data['productPrice']*data['quantity'];
                        //    cartController.updateCart(updateId:  data['cartId'],quantity: quantity, productPrice: price);
                        //         });
                        //       }, color: Colors.transparent, child: const Text('-',style: TextStyle(fontWeight: FontWeight.bold))),
                        //       SizedBox(width: size.width*.01,),
                        //     Text(data['quantity'].toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                        //                     SizedBox(width: size.width*.01,),
                          
                        //       NeumorphicButtonWidget(isCheck: false, press: (){
                        //         setState(() {
                        //      quantity=data['quantity'];
                        //         price=data['productPrice']*quantity;
                        //  cartController.updateCart(updateId: data['cartId'] ,quantity: quantity, productPrice: price);
                        //         });
                        //       }, color: Colors.transparent, child: const Text('+',style: TextStyle(fontWeight: FontWeight.bold))),           
                        //     ],),
                        ],),
                      ),
                    ],
                  ),
                );
                
                  });
          }else{
            return const Center(child: CircularProgressIndicator(backgroundColor: Colors.green,),);
          }
        }
      )
    );
  }

}