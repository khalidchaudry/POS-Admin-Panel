import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:simplecashier/notification/permision_handler.dart';
import 'package:simplecashier/provider/provider.dart';
import 'package:simplecashier/view/screens/cart_screen/cart_screen.dart';
import 'package:simplecashier/view/utils/utils.dart';
import '../../../notification/cloud_messaging_service.dart';
import '../../global_widgets/global_widgets.dart';

 
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Calculation
  String name='';
  String image='';
  String id='';
  double price=0.00;
  int quantity=1;
  int increaseQuantity=0;
  int decreaseQuantity=0;

  String  code='';
// Bool Values
 bool loading=false;
 bool nightMode=false;
 bool dayMode=false;
 bool search=false;
 bool printBtn=false;
 bool menuValue=false;
 bool decrementButtonValue=false;
 bool incrementButtonValue=false;
 bool barcodeValue=false;
 
//   Controller
 TextEditingController discountController=TextEditingController();
TextEditingController gstController=TextEditingController();
 // Firebase
final fireStoreSnapshot =firestore.collection('products').snapshots();
// get UID
  String uid='';
  String cartId='';
//   getUid()async{
// await firestore.collection('users').get().then((value) {
//   for (var i = 0; i < value.docs.length; i++) {
//     uid=value.docs[i]['uid'];
//   }
// });
// debugPrint(uid);

//   }
  // get Cart Id
   getCartUid()async{
await firestore.collection('cart').get().then((value) {
  for (var i = 0; i < value.docs.length; i++) {
    cartId=value.docs[i]['cartId'];
  }
});
debugPrint('Cart Id is#: $cartId');
  }
@override
  void initState() {
    PermissionHandler().getPermission();
    ColudMessagingService().fourGroundMessage();
    ColudMessagingService().appOpenButInBg();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getCartUid();
   final size= MediaQuery.of(context).size;
    var theme=Provider.of<ThemeProvider>(context);
    var nightClick=theme.darkTheme;
    return  OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) { 
       var customSize=MediaQuery.of(context).size;
        final isPortrait=orientation==Orientation.portrait;
          
        return Scaffold(
        
        floatingActionButton: FloatingActionButton(
        onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>  const CartScreen())), tooltip: 'Go to cart',
        child: const Icon(Icons.shopping_cart)),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColor.appBarBgColor,
          toolbarHeight: 80,
          title:Row(
            
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:  [
                        
                    NeumorphismButtonWidget(
                      press: (){                       
                        setState(() {
                         theme.toggleTheme(themeMode: ThemeMode.light);
                         
                            dayMode=!dayMode;
                          });
                      },
                      isCheck: dayMode,
                       color: AppColor.appBarBgColor, width: 50, height: 50, radius: 10, child: dayMode? const Icon(Icons.wb_sunny,color: Colors.orange,):const Icon(Icons.wb_sunny,color: Colors.orange,)),
                    NeumorphismButtonWidget(  press: (){
                       
                        setState(() {
                          nightClick=!nightClick;
                         
                           theme.toggleTheme(themeMode: ThemeMode.dark);
                            nightMode=!nightMode;
                          });
                      },
                      isCheck: nightMode,color: AppColor.appBarBgColor, width: 50, height: 50, radius: 10, child: nightMode? const Icon(Icons.nights_stay,color:Colors.black): const Icon(Icons.nights_stay,color:Colors.black)),
                    NeumorphismButtonWidget(  press: (){
                      setState(() {
                        search=!search;
                      });
                      showSearch(context: context, delegate: SearchDelegateWidget());
                    },isCheck: search,color: AppColor.appBarBgColor, width:size. width*.4, height: 50, radius: 10,
                     child:  Row(children:  [
                      SizedBox(width: size.width*.01,),
                      const Icon(Icons.search),const Text('Search here'),
                    ])
          ),
          
// NeumorphismButtonWidget(  press: (){
//                                              setState(() {
//                           barcodeValue=!barcodeValue;
//                                              });
//                                              Navigator.push(context, MaterialPageRoute(builder: (_)=> MobileScanner(
//                                  allowDuplicates: false,
//                                  controller: MobileScannerController(
//                                    facing: CameraFacing.back, torchEnabled: true),
//                                  onDetect: (barcode, args) {
//                                    if (barcode.rawValue == 'data['']') {
//                                      setState(() {
                                      
                                      //  cartProvider.addToCart(productName: data['ProductName'],
                                      //     productPrice:data['ProductPrice'],productImage: data['ProductImagee']);
//                                      flushBarErrorMessage('Barcode Matched', context);
//                                      });}
//                                      else{
//                                        flushBarErrorMessage('Not Matched', context);
//                                      }
//                                    }
//                                  ),));
//                                            },isCheck: barcodeValue,
//                                            color: AppColor.appBarBgColor, width:50, 
//                                            height: 50, radius: 10, child: Image.asset(Images.qr)
                    
//                           )
                          ] ),
          ),   
          body:
                StreamBuilder<QuerySnapshot>(
                  stream: fireStoreSnapshot,
                  builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data!.docs.isNotEmpty?GridView.builder(
                               shrinkWrap: true,
                        gridDelegate:   SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: isPortrait?3:5,
                              
                      mainAxisExtent: isPortrait?customSize.height*.24:customSize.height*.56,
                        ),
                        itemCount:
                        snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                         
                              final data=snapshot.data!.docs[index];
                              debugPrint(snapshot.data!.docs[index].toString());
                              return GridViewWidget(press: (){
                             showDialog(context: context, builder: (_){
                   final dialogHeight=SizedBox(height: size.height*.02,);
                bool cameraValue=false;
              
                return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {  
                    return SimpleDialog(
                    
                               contentPadding: const EdgeInsets.all(10),
                    children: [
                        Text('purchase ${data['ProductName']}',
                       textAlign: TextAlign.center,
                       style: const TextStyle(color:Colors.black,fontWeight: FontWeight.bold)),
                       dialogHeight,
    Text('$quantity X ${data['ProductPrice']} = ${quantity*data['ProductPrice']} SAR'.toString(),textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.blueGrey),),
                               dialogHeight,
                               Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                           NeumorphicButtonWidget(press: (){
                            if (quantity>1) {
                               setState(() {
                                             quantity--;
                    });
                            }
                   
                  }, color: Colors.transparent, isCheck: decrementButtonValue, child: const Text('-',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20))),
                               const SizedBox(width: 5,),
                  Text(quantity.toString()),
                  const SizedBox(width: 5,),
                  NeumorphicButtonWidget(press: (){
                    setState(() {
                     quantity++;
                    });
                  }, color: Colors.transparent, isCheck: incrementButtonValue, child:const Text('+',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                  
                         
                               ],),
                               dialogHeight,
                               SizedBox(
                                height: 50,
                                 child: TextFieldWidget(
                                          keyboardType: TextInputType.number,
                                         moveNextField: TextInputAction.done,
                                         hintText: 'Discount in %', boolCheck: true, controller: discountController),
                               ),
           dialogHeight,
                               SizedBox(
                                height: 50,
                                 child: TextFieldWidget(
           keyboardType: TextInputType.number,
          moveNextField: TextInputAction.done,
          hintText: 'GST in %', boolCheck: true, controller: gstController),
                               ),
                     dialogHeight,
                      NeumorphicButtonWidget(isCheck: cameraValue,
                       color: Colors.transparent,
                      press: () {  
                        if (gstController.text.isEmpty || discountController.text.isEmpty) {
                           cartController .addCart(productName: data['ProductName'],
                                    quantity: quantity,
                                     productPrice: data['ProductPrice'],
                                     productImage: data['ProductImage'],
                                     discount: 1,
                                     gst: 1
                                     );
                        }else{
                           cartController .addCart(productName: data['ProductName'],
                                    quantity: quantity,
                                     productPrice: data['ProductPrice'],
                                     productImage: data['ProductImage'],
                                     discount: discountController.text.toString(),
                                     gst: gstController.text.toString()
                                     );
                        }
                       

                               discountController.clear();
                               gstController.clear();
                        Navigator.pop(context);},
                      child:  const Text('Add',textAlign: TextAlign.center,),),
                     
                    ],
                  );
                  },
                );
              });
                                
                              },
                                    longPress:() => uploadController.deleteItems(id: data['id']),
                                    desc: data['ProductDesc'],
                                    image: data['ProductImage'], name: data['ProductName'], price: data['ProductPrice'],
            
            );
                
                      }): Center(child:Image.asset(Images.noInternet),);
                    }else{
                      return const Center(child: CircularProgressIndicator(),);
                    }
                  },
                
                )
                    );
      // const NoProductWidget(image: Images.noData);
       },     
    );
  }
}