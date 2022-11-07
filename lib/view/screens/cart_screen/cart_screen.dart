import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:printing/printing.dart';
import 'package:simplecashier/view/screens/cart_screen/widgets/printable_data.dart';
import 'package:simplecashier/view/screens/invoice_screen/invoice_screen.dart';
import '../../global_widgets/global_widgets.dart';
import '../../utils/utils.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}
class _CartScreenState extends State<CartScreen> {
int length=0;
List<int> quantity=[];
List<int> price=[];
double totalPrice=0.00;
List<String> name=[];
final  cartStore=firestore.collection('cart').snapshots();
// cart length
cartLegth(){
   firestore.collection('cart').get().then((value) {
    if (value.docs.isNotEmpty) {
     setState(() {
       length=value.docs.length;
     });
    }else{
      setState(() {
        length=0;
      });
    }
   });}
// Grand Total
grandTotal(){
   firestore.collection('cart').get().then((value) {
    int length=value.docs.length;
    if (value.docs.isNotEmpty) {
      
      for (var i=0; i<length; i++) {
        setState(() {
   totalPrice+=value.docs[i]['totalPrice'];
        });
      }
    }else{
      totalPrice=0.00;
    }
   });}
// Product name
getProductNames(){
   firestore.collection('cart').get().then((value) {
    int length=value.docs.length;
    if (value.docs.isNotEmpty) {
      
      for (var i=0; i<length; i++) {
        setState(() {
   name.add(value.docs[i]['productName']);
        });
      }
    }
   });}
// Quantity
// getQuantity(){
//    firestore.collection('cart').get().then((value) {
//     int length=value.docs.length;
//     if (value.docs.isNotEmpty) {
      
//       for (var i=0; i<length; i++) {
//         setState(() {
//    quantity.add(value.docs[i]['quantity']);
//         });
//       }
//     }
//    });}
   // Price
// getPrice(){
//    firestore.collection('cart').get().then((value) {
//     int length=value.docs.length;
//     if (value.docs.isNotEmpty) {
      
//       for (var i=0; i<length; i++) {
//         setState(() {
//    price.add(value.docs[i]['productPrice']);
//         });
//       }
//     }
//    });}
   @override
  void initState() {
    getProductNames();
    grandTotal();
    // getPrice();
    // getQuantity();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    cartLegth();
    var size=MediaQuery.of(context).size;
        return Scaffold(
       bottomNavigationBar: Padding(
         padding: const EdgeInsets.all(8.0),
         child: ListTile(
          title: const Text('Total'),
         subtitle:  Text(totalPrice.toStringAsFixed(2)),
         trailing: FloatingActionButton(
                             backgroundColor: Colors.green,
                             onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=> InvoiceScreen(totalPrice:totalPrice ))),                    
                           child: const Icon(Icons.print,color: Colors.white,),
                           )
         ),
       ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.green),
        centerTitle: true,
        elevation: .5,
        title:    Text('Cart ($length)',style: AppColor.appBarTextStyle,),
      backgroundColor: AppColor.appBarBgColor,
      actions: [IconButton(onPressed: (){
          showSearch(context: context, delegate: SearchDelegateWidget());
        }, icon: const Icon(Icons.search))],
      ),
      body:StreamBuilder<QuerySnapshot>(
        stream: cartStore,
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
          
          if (snapshot.hasData) {

            return snapshot.data!.docs.isNotEmpty?ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final data=snapshot.data!.docs[index];
              return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Container(
                            width: size.width*.3,
                            height: size.height*.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(image: NetworkImage(data['productImage'].toString()),
                              fit: BoxFit.cover
                              )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                              children: [                      
                               Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Text(data['productName'].toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                   TextButton(onPressed: (){
                                    cartController.deleteItems(cartID: data['cartId'].toString());
                                    debugPrint('************This ${data['cartId']} product Deleted************');
                                   }, child:  const Icon(CupertinoIcons.delete_left,color: Colors.red,))
                                 ],
                               ),
                               SizedBox(height:size.height*.04),
                          Text('${data['quantity']} X ${data['productPrice']} = ${data['totalPrice']} SAR'.toString(),style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.blueGrey),),
                            ],),
                          ),
                        ],
                      ),
                    );
            }):Center(child: Image.asset(Images.noInternet),);
          }
          else{
            return const Center(child: CircularProgressIndicator(backgroundColor: Colors.green,),);
          }
          
        }
      ),
    );
  }
  
  // Printer 
 Future<void> printDoc() async {
    var  image = imageFromAssetBundle(
    Images.inventory
    );
    final doc = pw.Document();
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return 
          buildPrintableData(image:image ,length: length,name: name,totalPrice: totalPrice);
        }));
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }
}