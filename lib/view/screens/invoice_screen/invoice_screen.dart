import 'dart:io';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:simplecashier/view/screens/invoice_screen/print_page.dart';
import 'package:simplecashier/view/screens/invoice_screen/widget/icon_text_widget.dart';
import '../../global_widgets/global_widgets.dart';
import '../../utils/utils.dart';

class InvoiceScreen extends StatefulWidget {
  final String invoiceId;
  const InvoiceScreen({super.key, required this.invoiceId});
  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  ScreenshotController screenShootController=ScreenshotController();
  final printData=firestore.collection('invoices').snapshots();
  String dir=Directory.current.path;
  // testPrint({required String printerIp,required Uint8List image})async{
  //    final profile= await CapabilityProfile.load();
  //    final generator=Generator(PaperSize.mm80, profile);
  //    final availableProfiles = await CapabilityProfile.getAvailableProfiles();
  // }
  @override
  Widget build(BuildContext context) {
  bool printValue=false;
    final size=MediaQuery.of(context).size;
     return Scaffold(
  floatingActionButton: 
             FloatingActionButton(
    backgroundColor: Colors.green,
    onPressed: ()async{
      await screenShootController.capture().
      then((value) =>invoiceController.invoiceFireStore(invoiceImage:value!),
       );
       Navigator.push(context, MaterialPageRoute(builder: (_)=> const PrintPage()));
    },
  child: const Icon(Icons.print,color: Colors.white,),
  ),
body:SafeArea(
  child:   Screenshot(
    controller: screenShootController,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:   [
        CircleAvatar(radius: 70,
        backgroundImage: const AssetImage(Images.splashImage),
        onBackgroundImageError: (exception, stackTrace) => const AssetImage(Images.noProduct),
        ),
        SizedBox(height: size.height*.03,),
        const Text('KB',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
            SizedBox(height: size.height*.02,),
      // const IconTextWidget(text: 'KhalidChaudry130@gmail.com', iconData: Icons.email),
        const IconTextWidget(text: '03415951293', iconData: Icons.phone),
            SizedBox(height: size.height*.03,),
            RowTextWidget(text1: 'Date:', text2: '${DateTime.now()}',text1Bold: const TextStyle(fontWeight: FontWeight.normal),text2Bold: const TextStyle(fontWeight: FontWeight.normal),),
            //  const RowTextWidget(text1: 'Customer Name:', text2: 'Zaki',text1Bold: TextStyle(fontWeight: FontWeight.normal),text2Bold: TextStyle(fontWeight: FontWeight.normal)),
           const Divider(thickness: 2,),
          const RowTextWidget(text1: '2 X ProductName(1200 PKR)', text2: '1200 PKR',text1Bold: TextStyle(fontWeight: FontWeight.normal),text2Bold: TextStyle(fontWeight: FontWeight.normal)),
           const Divider(thickness: 1,),
           const RowTextWidget(text1: '2 X ProductName(1100 PKR)', text2: '1100 PKR',text1Bold: TextStyle(fontWeight: FontWeight.normal),text2Bold: TextStyle(fontWeight: FontWeight.normal)),
           const Divider(thickness: 1,),
           const RowTextWidget(text1: '2 X ProductName(900 PKR)', text2: '900 PKR',text1Bold: TextStyle(fontWeight: FontWeight.normal),text2Bold: TextStyle(fontWeight: FontWeight.normal)),
           const Divider(thickness: 1,),
           const RowTextWidget(text1: 'Total', text2: '3200 PKR',text1Bold: TextStyle(fontWeight: FontWeight.bold),text2Bold: TextStyle(fontWeight: FontWeight.bold)),
           const Divider(thickness: 2,),
           const RowTextWidget(text1: 'Discount(100 PKR)', text2: '100 PKR',text1Bold: TextStyle(fontWeight: FontWeight.bold),text2Bold: TextStyle(fontWeight: FontWeight.bold)),
           const Divider(thickness: 2,),
           const RowTextWidget(text1: 'Grand total', text2: '3100 PKR',text1Bold: TextStyle(fontWeight: FontWeight.bold),text2Bold: TextStyle(fontWeight: FontWeight.bold)),
           const Divider(thickness: 2,),
          SizedBox(height: size.height*.03,),
           const Text('Thank You For Shopping With Us, Please Come Again',style: TextStyle(fontSize: 12),),
              SizedBox(height: size.height*.03,),
              Image.asset(Images.qr,width: 50,height: 50,),
                          SizedBox(height: size.height*.01,),
                       const Text('Here Barcode',style: TextStyle(fontSize: 12),),
  ]),
    ),          
        ),
)
 
     );
  }
}