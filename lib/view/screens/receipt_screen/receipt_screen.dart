import 'package:flutter/material.dart';
import '../../global_widgets/global_widgets.dart';
import '../../utils/utils.dart';
import 'widgets/widget.dart';
class ReceiptScreen extends StatefulWidget {
  const ReceiptScreen({super.key});

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  final invoice=firestore.collection('invoices').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(),
        centerTitle: true,
        elevation: .5,
        title: const Text('Receipts',style: AppColor.appBarTextStyle,),
      backgroundColor: AppColor.appBarBgColor,
      actions: [IconButton(onPressed: (){
          showSearch(context: context, delegate: SearchDelegateWidget());
        }, icon: const Icon(Icons.search))],
      ),
      body:ListView.builder(
                itemCount:5,
                itemBuilder: (context, index) {
                  const data=5;
               return Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: ListTile(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_)=>const ReceiptDetailWidget(image: ''))),
                  title: const Text('data'),)
               );}
              ),
    );
    
  }
}