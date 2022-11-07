import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';
import 'package:simplecashier/view/screens/cart_screen/widgets/printable_data.dart';
import 'package:simplecashier/view/screens/invoice_screen/widget/icon_text_widget.dart';
import '../../global_widgets/global_widgets.dart';
import '../../utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
class InvoiceScreen extends StatefulWidget {
  final double totalPrice;
  const InvoiceScreen({super.key, required this.totalPrice});
  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  final printData=firestore.collection('invoices').snapshots();
 String invoice='';
List  name=[];
List<dynamic> price=[];
int length=1;
List image=[];
List<dynamic> quantity=[];
List<dynamic> totalPrice=[];
List<QuerySnapshot>? docs;

getMessagesTest222() async{
    QuerySnapshot querySnapshot = await firestore.collection('cart').get();
     setState(() {
       name = querySnapshot.docs.map((doc) => doc.get('productName')).toList();
     price = querySnapshot.docs.map((doc) => doc.get('productPrice')).toList();
     image = querySnapshot.docs.map((doc) => doc.get('productImage')).toList();
     quantity = querySnapshot.docs.map((doc) => doc.get('quantity')).toList();
     totalPrice = querySnapshot.docs.map((doc) => doc.get('totalPrice')).toList();
     });
    debugPrint('Name......${name.toString()}');
    debugPrint('Price......${price.toString()}');
    debugPrint('Image......${image.toString()}');
    debugPrint('Quantity......${quantity.toString()}');
    debugPrint('Total Price......${totalPrice.toString()}');
  }

  static GlobalKey imageKey=GlobalKey();
  Uint8List? imageData;
  @override
  void initState() {
        getMessagesTest222();
     
    super.initState();
  }
   
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
     return Scaffold(
  floatingActionButton: 
             FloatingActionButton(
    backgroundColor: Colors.green,
    onPressed:()async{
      // RenderRepaintBoundary boundary=imageKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      // ui.Image image=await boundary.toImage(pixelRatio: 3);
      // ByteData? byte=await image.toByteData(format: ui.ImageByteFormat.png);
      // setState(() {
      //   imageData=byte!.buffer.asUint8List();
      // });
      // debugPrint(imageData.toString());
      printDoc();
    },
  child: const Icon(Icons.print,color: Colors.white,),
  ),
body:SafeArea(
  child:   Padding(
      padding: const EdgeInsets.all(10.0),
      child: RepaintBoundary(
        key: imageKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:   [
          CircleAvatar(radius: 70,
          backgroundImage:  const AssetImage(Images.inventory),
          onBackgroundImageError: (exception, stackTrace) => const AssetImage(Images.noProduct),
          ),
          SizedBox(height: size.height*.03,),
          const Text('KB',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              SizedBox(height: size.height*.02,),
        // const IconTextWidget(text: 'KhalidChaudry130@gmail.com', iconData: Icons.email),
          const IconTextWidget(text: '03415951293', iconData: Icons.phone),
              SizedBox(height: size.height*.03,),
               RowTextWidget(text1: 'Date:', text2: DateFormat().format(DateTime.now()).toString(),text1Bold: const TextStyle(fontWeight: FontWeight.bold),text2Bold: const TextStyle(fontWeight: FontWeight.bold),),
              //  const RowTextWidget(text1: 'Customer Name:', text2: 'Zaki',text1Bold: TextStyle(fontWeight: FontWeight.normal),text2Bold: TextStyle(fontWeight: FontWeight.normal)),
             const Divider(thickness: 2,),
             Expanded(
               child: StreamBuilder<QuerySnapshot>(
                stream: firestore.collection('cart').orderBy('quantity').snapshots(),
                builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                 if (snapshot.hasData) {
                   return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final data=snapshot.data!.docs[index];
                      // price=data['productPrice'];
                      // name.add(data['productName']);
                      length=snapshot.data!.docs.length;
                      // quantity=data['quantity'];
                      // docs=snapshot.data!.docs.cast<QuerySnapshot<Object?>>();
                      // debugPrint(name.toString());
                     return  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         RowTextWidget(text1: '${data['quantity']} X ${data['productName']}(${data['productPrice']} PKR)', text2: '${(data['quantity']*data['productPrice']).toStringAsFixed(2)} PKR',
                         text1Bold: const TextStyle(fontWeight: FontWeight.normal),text2Bold: const TextStyle(fontWeight: FontWeight.normal)),
                          const Divider(thickness: 2,),
                       ],
                     );
                   });
                 }else{
                  return const Center(child: CircularProgressIndicator(backgroundColor: Colors.green,),);
                 }
               }),
             ),          
               RowTextWidget(text1: 'Total', text2: '${widget.totalPrice} PKR',text1Bold: const TextStyle(fontWeight: FontWeight.bold),text2Bold: const TextStyle(fontWeight: FontWeight.bold)),
             const Divider(thickness: 2,),
             const RowTextWidget(text1: 'Discount(100 PKR)', text2: '100 PKR',text1Bold: TextStyle(fontWeight: FontWeight.bold),text2Bold: TextStyle(fontWeight: FontWeight.bold)),
             const Divider(thickness: 2,),
              RowTextWidget(text1: 'Grand total', text2: '${widget.totalPrice-100} PKR',text1Bold: const TextStyle(fontWeight: FontWeight.bold),text2Bold: const TextStyle(fontWeight: FontWeight.bold)),
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
        ),

 
     );
  }
  // Direct print
   _printPdf() async {
    final printers = await Printing.listPrinters();
    debugPrint('Printers............${printers.toString()}');
        final doc = pw.Document();

    await Printing.directPrintPdf(
        printer: printers.first, onLayout: (_) => doc.save());
  }
    // Printer 
 Future<void> printDoc() async {
    var  image = await imageFromAssetBundle(
    Images.inventory,
    );
    final doc = pw.Document();
var arabicFont = pw.Font.ttf(await rootBundle.load("assets/fonts/Hacen Tunisia.ttf"));

    doc.addPage(pw.Page(
       pageFormat: PdfPageFormat.roll80,
       theme: pw.ThemeData.withFont(
        bold: arabicFont,
        italic: arabicFont,
        icons: arabicFont,
    base: arabicFont,
    fontFallback: [arabicFont]
  ),
        build: (pw.Context context) {
          return pw.Directionality(
            textDirection: pw.TextDirection.rtl,
          child:pw.Column(children: [
           
        pw.Align(
          child: pw.Image(
            image,
            width: 80,
            height: 80,
          ),
        ),
                        pw.SizedBox(height: 10),
        
    pw.Text('KB',style: pw.TextStyle(fontSize: 22,fontWeight: pw.FontWeight.bold,),),
            
                pw.SizedBox(height: 5.5),
                   
                     pw.Row(
      children: [
                        pw.Text('Invoice# ',style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),
                pw.Text(randomNumber.toString()),
    ],),
                pw.Row(
      children: [
                        pw.Text('Company Number: ',style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),
                pw.Text('+923415951293'),
    ],),
  pw.Row(
      children: [
      pw.Text('Date Time: ',style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),
      pw.Text(DateFormat().format(DateTime.now()).toString()),
    ],),
              
            pw.Divider(thickness: 2),            
              pw.ListView.builder(itemBuilder: (context, index) {
             return pw.Column(children: [
           pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
      pw.Text('${quantity[index]} X ${name[index]} (${price[index]})',style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),
      pw.Text('${quantity[index]*price[index]} SAR',style:  pw.TextStyle(fontWeight: pw.FontWeight.bold),),
            ]),
             ]);
           },
            itemCount: length),
    pw.Divider(thickness: 2),
     pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
       pw.Text("Sub Total",
            style:
                pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold)),
                pw.Text('${widget.totalPrice.toStringAsFixed(2)} SAR',
            style:
                pw.TextStyle(fontSize:13, fontWeight: pw.FontWeight.bold,
                fontFallback: const [
                ]
                )),
    ]),
    
    pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text("10 PKR",
            style:
                pw.TextStyle(fontSize:13, fontWeight: pw.FontWeight.bold)),
       pw.Text("تخفيض",
                     textDirection: pw.TextDirection.rtl,
            style:
                pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold,
                fontFallback: [arabicFont]
                )),
                
    ]),
   pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
         pw.Text('${widget.totalPrice.toStringAsFixed(2)} SAR',
            style:
                pw.TextStyle(fontSize:13, fontWeight: pw.FontWeight.bold)),
       pw.Text("المبلغ الإجمالي",
                     textDirection: pw.TextDirection.rtl,
            style:
                pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold,
                fontFallback: [arabicFont]
                )),
               
    ]),
    
           pw.SizedBox(height: 15.00),
    pw.Container(
          height: 40,
          width: 100,
          child: pw.BarcodeWidget(
            barcode: pw.Barcode.code128(),
            data: 'Invoice# $randomNumber',
            drawText: false,
          ),
        ),
         pw.SizedBox(height: 15.00),
         pw.BarcodeWidget(
                          data: 'KB\nInvoice# $randomNumber',
                          width: 60,
                          height: 60,
                          barcode: pw.Barcode.qrCode(),
                          drawText: false,
                        ),
            pw.SizedBox(height: 15.00),
            pw.Text('شكرا لاختيارك خدمتنا! ارجوك عد مجددا',
              // "Thanks for choosing our service! Please come again",
              style:  const pw.TextStyle(
                
                  fontSize: 13.00,
                  ),

            ),
            pw.SizedBox(height: 5.00),
            pw.Text(
              "تواصل مع الفرع لأية توضيحات",
              style: const pw.TextStyle(
                   fontSize: 13.00),
            ),          
]));
        }));
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
//         await for (var page in Printing.raster(await doc.save(), pages: [0, 1], dpi: 72)) {
//   final image = page.toImage(); // ...or page.toPng()
//   debugPrint(image.toString());
// }
  }
}