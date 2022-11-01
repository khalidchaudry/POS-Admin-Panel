import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../../utils/utils.dart';
import '../cart_screen.dart';
class CartItemsListWidget extends StatelessWidget {
  const CartItemsListWidget({super.key});
  @override
  Widget build(BuildContext context) {
        return Expanded(
          child: StreamBuilder<QuerySnapshot>(
          stream: firestore.collection('cart').snapshots(),
          builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data=snapshot.data!.docs[index];
                    return const SizedBox();
                  // return  CartScreen(name: data['productName'],image: data['productImage'],
                  // price: data['productPrice'],id: data['cartId'],quantity: data['quantity'],);
                    });
            }else{
              return const Center(child: CircularProgressIndicator(backgroundColor: Colors.green,),);
            }
          }
              ),
        );
  }

}