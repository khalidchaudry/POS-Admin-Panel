import 'dart:math';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
// Invoice number
int randomNumber=Random().nextInt(0123456789);
// List<QueryDocumentSnapshot<Map<String, dynamic>>> data;
buildPrintableData({required image,required name,required length,required totalPrice,}) => pw.Padding(
      padding: const pw.EdgeInsets.all(25.00),
      child: pw.Column(children: [
        pw.Align(
          child: pw.Image(
            image,
            width: 80,
            height: 80,
          ),
        ),
                        pw.SizedBox(height: 10),
        pw.Column(
          children: [
    pw.Text('KB',style: pw.TextStyle(fontSize: 22,fontWeight: pw.FontWeight.bold),),
            
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
      pw.Text(DateFormat().format(DateTime.now()).toString(),style: const pw.TextStyle(),),
    ],)
              ],
            ),
            pw.Divider(thickness: 2),
            // for(var i=0;i<length;i++)
              // pw.Text('quantity X name (price)',style: pw.TextStyle(fontWeight: pw.FontWeight.bold),),
      // pw.Text('{quantity*price} SAR',style:  pw.TextStyle(fontWeight: pw.FontWeight.bold),),
    pw.Divider(thickness: 2),
    //  pw.Row(
    // mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    //   children: [
    //    pw.Text("Sub Total",
    //         style:
    //             pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
    //             pw.Text('${totalPrice.toStringAsFixed(2)} SAR',
    //         style:
    //             pw.TextStyle(fontSize:15, fontWeight: pw.FontWeight.bold)),
    // ]),
    pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
       pw.Text("Discount",
            style:
                pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
                pw.Text("10PKR",
            style:
                pw.TextStyle(fontSize:15, fontWeight: pw.FontWeight.bold)),
    ]),
     pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
       pw.Text("Grand Total",
            style:
                pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
                pw.Text('${totalPrice.toStringAsFixed(2)} SAR',
            style:
                pw.TextStyle(fontSize:15, fontWeight: pw.FontWeight.bold)),
    ]),
  
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
            pw.Text(
              "Thanks for choosing our service! Please come again",
              style: const pw.TextStyle(
                  fontSize: 15.00),
            ),
            pw.SizedBox(height: 5.00),
            pw.Text(
              "Contact the branch for any clarifications.",
              style: const pw.TextStyle(
                   fontSize: 15.00),
            ),          
]));
