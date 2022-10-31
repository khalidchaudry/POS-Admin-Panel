import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simplecashier/view/screens/CartPage/single_item_cart.dart';

class CartsPage extends StatefulWidget {
  const CartsPage({Key? key}) : super(key: key);

  @override
  State<CartsPage> createState() => _CartsPageState();
}

class _CartsPageState extends State<CartsPage> {
  int quantity = 1;

  void quantityFunction(String collection, String documentIdd) {
    FirebaseFirestore.instance
        .collection(collection)
        .doc(documentIdd)
        .update({"quantity": quantity.toString()});
  }

  void totalPriceFunction(String collection, String documentIdd) {
    FirebaseFirestore.instance
        .collection(collection)
        .doc(documentIdd)
        .update({"totalPrice": totalPrice.toString()});
  }

  void deleteProductFunction(String collection, String documentIdd) {
    FirebaseFirestore.instance.collection(collection).doc(documentIdd).delete();
  }

  int? totalPrice;
  String? productIdd;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Center(
          child: Text(
            "مطاعم شواية الخليج",
            style: TextStyle(color: Colors.red),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.8,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("cart")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          QueryDocumentSnapshot ds = snapshot.data!.docs[index];
                          // return ds['isAdd'] == "TRUE"
                          //     ? teamData2(index, ds)
                          //     : const Center(child: Text('No Data'),);
                          return teamData2(index, ds);
                        },
                      );
                    } else if (snapshot.hasError) {
                      return const Center(child: Icon(Icons.error_outline));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
           
          ],
        ),
      ),
    ));
  }

  Widget teamData2(int index, QueryDocumentSnapshot ds) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.7),
            blurRadius: 10,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(ds['productImage']),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        ds['productName'],
                        style: const TextStyle(),
                      ),
                      // Text(
                      //   ds['productDetail'],
                      //   style: const TextStyle(
                      //     fontSize: 13,
                      //   ),
                      // ),
                      Text(
                        "(SAR ${ds['productPrice']})",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Text(
                      //   ds['totalPrice'],
                      //   style: const TextStyle(
                      //     fontSize: 13,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IncreaseDecrease(
                            icon: Icons.add,
                            onPressed: () {
                              setState(() {
                                quantity++;
                                totalPrice =
                                    quantity * int.parse(ds['productPrice'].toString());
                                quantityFunction("cart", ds.id);
                                totalPriceFunction("cart", ds.id);
                              });
                            },
                          ),
                          Text(
                            ds['quantity'].toString(),
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          IncreaseDecrease(
                            icon: Icons.remove,
                            onPressed: () {
                              if (quantity > 1) {
                                setState(() {
                                  quantity--;
                                  totalPrice =
                                      quantity * int.parse(ds['productPrice']);
                                  quantityFunction("cart", ds.id);
                                  totalPriceFunction("cart", ds.id);
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              deleteProductFunction("cart", ds.id);
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}
