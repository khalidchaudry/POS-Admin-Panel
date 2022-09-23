import 'package:flutter/material.dart';
import 'package:simplecashier/view/screens/home_screen/widgets/rounded_button_widget.dart';

class BottomWidget extends StatelessWidget {
  // const BottomWidget({super.key});
bool loading=false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
      child: Column(children:  [
        const Divider(thickness: 2,),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RoundedButtonWidget(text: 'CLEAR', loading: loading,press: (){}, color: Colors.red,width: 160,height: 40,),
            RoundedButtonWidget(text: 'CHECK OUT',loading: loading, press: (){}, color: Colors.green,width: 160,height: 40,),
          ],
        ),
        const SizedBox(height: 10,),

       Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:  [
        Column(
          children: const [
            Text('TOTAL',style: TextStyle(fontWeight: FontWeight.bold),),
             Text('0.00'),
          ],
        ),
                const SizedBox(height: 50,child: VerticalDivider(thickness: 2,color: Colors.black,)),

         Column(
          children: const [
            Text('TOTAL ITEMS',style: TextStyle(fontWeight: FontWeight.bold)),
             Text('0'),
          ],
        ), 
                const SizedBox(height: 50,child: VerticalDivider(thickness: 2,color: Colors.black,)),

        Column(
          children: const [
            Text('QUANTITY',style: TextStyle(fontWeight: FontWeight.bold)),
             Text('0'),
          ],
        ),
       
       ],),
       
      ],),
    );
  }
}