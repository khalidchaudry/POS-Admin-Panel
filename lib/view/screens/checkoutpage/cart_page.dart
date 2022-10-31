import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../provider/provider.dart';
import '../CartPage/single_item_cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getFromCart();

    return Scaffold(
      // bottomNavigationBar: cartProvider.getAhmedCartlist.isEmpty
         
      appBar: AppBar(
        elevation: 0,
        
        backgroundColor: Colors.transparent,
        title: const Center(
          child: Text(
            "مطاعم شواية الخليج",
            style: TextStyle(fontFamily: 'ElMessiri', color: Colors.red),
          ),
        ),
      ),
      body: cartProvider.getAhmedCartlist.isEmpty
          ? const Center(
              child: Text(
                "قم بملء سلة طعامك من فضلك",
                style: TextStyle(fontFamily: "ElMessiri"),
              ),
            )
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: cartProvider.getAhmedCartlist.length,
              itemBuilder: (ctx, index) {
                var data = cartProvider.getAhmedCartlist[index];
                return SingleCartItem(
                  productImage: data.productImage!,
                  productPrice: data.productPrice!,
                  productQuantiy: data.productQuantiy!,
                  productName: data.productName!,
                  productId: data.productId!,
                );
              },
            ),
    );
  }
}
