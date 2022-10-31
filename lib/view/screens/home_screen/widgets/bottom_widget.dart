import 'package:flutter/material.dart';



class BottomWidget extends StatefulWidget {
   BottomWidget({super.key,
  required this.items, required this.colors, required this.quantity, required this.total,
  });
   double total;
  int items;
   int quantity;
Color colors;
  @override
  State<BottomWidget> createState() => _BottomWidgetState();
}

class _BottomWidgetState extends State<BottomWidget> {
bool loading=false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
      child: Column(children:  [
        const Divider(thickness: 2,),
        // RoundedButtonWidget(text: 'CLEAR', loading: loading,press: (){setState(() {
        // widget.total=0;
        // widget.items=0;
        // widget.quantity=0;
        // widget.colors=Colors.purple;
        // });}, color: widget.colors,width: double.infinity,height: 40,),
        const SizedBox(height: 10,),

       Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:  [
        Column(
          children:  [
            const Text('TOTAL',style: TextStyle(fontWeight: FontWeight.bold),),
             Text(widget.total.toStringAsFixed(2)),
          ],
        ),
                const SizedBox(height: 50,child: VerticalDivider(thickness: 2,color: Colors.black,)),

         Column(
          children:  [
            const Text('TOTAL ITEMS',style: TextStyle(fontWeight: FontWeight.bold)),
             Text(widget.items.toString()),
          ],
        ), 
                const SizedBox(height: 50,child: VerticalDivider(thickness: 2,color: Colors.black,)),

        Column(
          children:  [
            const Text('QUANTITY',style: TextStyle(fontWeight: FontWeight.bold)),
             Text(widget.quantity.toString()),
          ],
        ),
       
       ],),
       
      ],),
    );
  }
}