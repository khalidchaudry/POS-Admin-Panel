import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:simplecashier/view/screens/receipt_screen/widgets/widget.dart';
import 'package:simplecashier/view/utils/app_colors.dart';
import 'package:simplecashier/view/utils/constants.dart';

import '../../global_widegts/global_widgets.dart';
class ReceiptScreen extends StatefulWidget {
  const ReceiptScreen({super.key});

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
 ScreenshotController controller=ScreenshotController();
final invoice=firestore.collection('products').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Receipts'),
      backgroundColor: AppColor.appBarBgColor,
      actions: [IconButton(onPressed: (){
          showSearch(context: context, delegate: SearchDelegateWidget());
        }, icon: const Icon(Icons.search))],
      ),
      body:
      StreamBuilder<QuerySnapshot>(
        stream: invoice,
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final data=snapshot.data!.docs[index];
           return Padding(
             padding: const EdgeInsets.all(7.0),
             child: ListTile(

              dense: true,
              enabled: true,
              tileColor: Colors.black12,
              
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>ReceiptDetailWidget(image: data['ProductInvoice']))),
                title: Text('Invoice Name: ${data['ProductName']}',style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              subtitle: Text('Date Time:${data['InvoiceDateTime']}',style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
              ),
           );}
          );
          }
          else{
            return const Center(child: CircularProgressIndicator(backgroundColor: AppColor.appBarBgColor,),);
          }
          
        }
      ),
    );
  }
}