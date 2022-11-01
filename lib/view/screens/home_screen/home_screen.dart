import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:simplecashier/notification/permision_handler.dart';
import 'package:simplecashier/provider/provider.dart';
import 'package:simplecashier/view/utils/utils.dart';
import '../../../notification/cloud_messaging_service.dart';
import '../../global_widgets/global_widgets.dart';
import '../cart_screen/cart_screen.dart';

 
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
 TextEditingController controller=TextEditingController();
 // Firebase
final fireStoreSnapshot =firestore.collection('products').snapshots();
@override
  void initState() {
    PermissionHandler().getPermission();
    ColudMessagingService().getToken();
    ColudMessagingService().fourGroundMessage();
    ColudMessagingService().appOpenButInBg();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   final size= MediaQuery.of(context).size;
    var theme=Provider.of<ThemeProvider>(context);
    var nightClick=theme.darkTheme;
    return  OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) { 
       var customSize=MediaQuery.of(context).size;
        final isPortrait=orientation==Orientation.portrait;
          
        return Scaffold(
        
        floatingActionButton: FloatingActionButton(
        onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>  CartScreen())), tooltip: 'Go to cart',
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
                      return GridView.builder(
                               shrinkWrap: true,
                        gridDelegate:   SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: isPortrait?3:5,
                              mainAxisSpacing: customSize.height*.0199,
                              crossAxisSpacing: customSize.width*.0199,
                      mainAxisExtent: isPortrait?customSize.height*.24:customSize.height*.56,
                        ),
                        itemCount:
                        snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                         
                              final data=snapshot.data!.docs[index];
                              debugPrint(snapshot.data!.docs[index].toString());
                              return GridViewWidget(press: ()=>cartController .addCart(productName: data['ProductName'],
                                  quantity: quantity,
                                   productPrice: data['ProductPrice'],productImage: data['ProductImage']), longPress:() => uploadController.deleteItems(id: data['id']),
image: data['ProductImage'], name: data['ProductName'], price: data['ProductPrice'],
            
            );
                
                      });
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