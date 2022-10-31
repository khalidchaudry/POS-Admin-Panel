import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../provider/provider.dart';

class SingleCartItem extends StatefulWidget {
  final String productImage;
  final String productName;
  final double productPrice;
  final int productQuantiy;
  final String productId;

  const SingleCartItem({
    Key? key,
    required this.productId,
    required this.productImage,
    required this.productName,
    required this.productPrice,
    required this.productQuantiy,
  }) : super(key: key);

  @override
  State<SingleCartItem> createState() => _SingleCartItemState();
}

class _SingleCartItemState extends State<SingleCartItem> {
  int quantity = 1;

  int totalPriceOfAddedPrice = 2;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0.0),
      margin: const EdgeInsets.all(20.0),
      // height: 220,
      // width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.loose,
        clipBehavior: Clip.none,
        alignment: Alignment.topRight,
        children: [
          Row(
            children: [
              Image.network(widget.productImage,fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.45,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15,top: 8,bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      widget.productName,
                      style: const TextStyle(),
                    ),
                    // getTextWidgets(widget.extra),
                    myCalculation(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IncreaseDecrease(
                          icon: Icons.remove,
                          onPressed: () {
                            Provider.of<CartProvider>(context, listen: false)
                                .decreaseQuantity(widget.productId);
                            // idList.remove(widget.productId);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            widget.productQuantiy.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        IncreaseDecrease(
                          icon: Icons.add,
                          onPressed: () {
                            Provider.of<CartProvider>(context, listen: false)
                                .increaseQuantity(widget.productId);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              Provider.of<CartProvider>(context, listen: false)
                  .removeItemFromCart(widget.productId);
              // idList.remove(widget.productId);
              // deleteProductFunction();
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }

  Widget getTextWidgets(List<String> strings)
  {
    return Column(children: strings.map((item) => Text(item)).toList());
  }

  myCalculation() {
    double value = widget.productPrice * widget.productQuantiy;

    return SizedBox(
      width: 110,
      child: Text(
        "(ريال )$value",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

}

class IncreaseDecrease extends StatelessWidget {
  final Function()? onPressed;
  final IconData icon;

  const IncreaseDecrease({
    Key? key,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 40,
      height: 30,
      elevation: 2,
      color: Colors.grey[100],
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(icon),
    );
  }
}
