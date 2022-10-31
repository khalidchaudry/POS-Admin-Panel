import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../provider/provider.dart';
import '../CartPage/single_item_cart.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  String? productId;

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getFromCart();

    int subTotal = cartProvider.subTotalAhmed();
   
    double totalPrice=0.00;

    if (cartProvider.getAhmedCartlist.isEmpty) {
      setState(() {
        totalPrice = 0.0;
      });
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.email,
          ),
        ),
        backgroundColor: Colors.transparent,
        title: const Center(
          child: Text(
            "مطاعم شواية الخليج",
            style: TextStyle(fontFamily: 'ElMessiri', color: Colors.red),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: cartProvider.cartList.isEmpty
                    ? const Center(
                        child: Text(
                          "قم بملء سلة طعامك من فضلك",
                          style: TextStyle(fontFamily: 'ElMessiri'),
                        ),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: cartProvider.cartList.length,
                        itemBuilder: (ctx, index) {
                          var data = cartProvider.cartList[index];
                          return SingleCartItem(
                            productImage: data.productImage!,
                            productPrice: data.productPrice!,
                            productQuantiy: data.productQuantiy!,
                            productName: data.productName!,
                            productId: data.productId!,
                          );
                        },
                      ),
              ),
              Expanded(
                child: Column(
                  children: [
                    ListTile(
                      leading:   Text("(SAR $subTotal)"),
                      trailing: const Text("Sub Totle"),
                    ),
                   
                    const Divider(
                      thickness: 2,
                    ),
                    ListTile(
                      trailing: const Text("Total"),
                      leading: Text("(ريال $totalPrice)"),
                    ),
                    
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
