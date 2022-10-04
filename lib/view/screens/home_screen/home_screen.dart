
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:simplecashier/provider/theme_provider.dart';

import '../../global_widegts/global_widgets.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import 'widgets/widget.dart';
 
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  String name='';
  String image='';
  String id='';
  double incrementPrice=0.00;
  double price=0.00;
  int quantity=0;
  int totalItems=0;
  var data=0.00;
  Color changeColor=Colors.grey;
Color color=Colors.grey;
 bool loading=false;
 TextEditingController controller=TextEditingController();
final fireStoreSnapshot =firestore.collection('products').snapshots();
ScreenshotController screenshotController=ScreenshotController();
 
  @override
  Widget build(BuildContext context) {
    var theme=Provider.of<ThemeProvider>(context);
    var click=theme.darkTheme;
    return  OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) { 
        final isPortrait=orientation==Orientation.portrait;
        
  isTablet(BuildContext context)=>MediaQuery.of(context).size.width>=600;
  isMobile(BuildContext context)=>MediaQuery.of(context).size.shortestSide<600;
        return DefaultTabController(
        length: 2,
        child: Scaffold(
         
          drawer: const DrawerWidget(),
          appBar: AppBar(
            
            title: const Text(AppString.appName),elevation: 0,backgroundColor: AppColor.appBarBgColor,
          actions: [IconButton(onPressed: (){
            showSearch(context: context, delegate: SearchDelegateWidget());
          }, icon: const Icon(Icons.search)),
          IconButton(onPressed: (){
            theme.toggleTheme();
          }, icon: click?const Icon(Icons.wb_sunny):const Icon(Icons.nights_stay)),
          ],
          ),
          body: Screenshot(
            controller: screenshotController,
            child: SingleChildScrollView(
              
              child: Column(children:   [
                Container(
               
                color: AppColor.appBarBgColor,
                child:   const TabBar(
                  indicatorColor: Colors.white,
                  tabs: [Tab(text: 'ITEM',),
                Tab(text: 'CART',)
                ]),
                ),
                  SizedBox(
                    width: double.infinity,
                  height: isPortrait?MediaQuery.of(context).size.height*.7:MediaQuery.of(context).size.height,
                  
                   child: TabBarView(children: [
                    
                                 StreamBuilder<QuerySnapshot>(
              
              stream: fireStoreSnapshot,
              builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isPortrait?3:4,
                  mainAxisExtent: isPortrait?MediaQuery.of(context).size.height*.24:MediaQuery.of(context).size.height*.4,
                
                ),
                itemCount:snapshot.data!.docs.length,
                
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                    
                        InkWell(
                          onTap: (){
                            setState(() {
                              color=Colors.green;
                              totalItems=1;
                              quantity+=1;
                              incrementPrice=(snapshot.data!.docs[index]['ProductPrice']*quantity);
                              name=snapshot.data!.docs[index]['ProductName'];
                              image=snapshot.data!.docs[index]['ProductImage'];
                              price=snapshot.data!.docs[index]['ProductPrice'];
                              id=snapshot.data!.docs[index]['id'];
                });
                          },
                          child: 
                          Container(               
                          decoration: BoxDecoration(
                        
                                        border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.2)),
                                        color: Colors.white,
                                        boxShadow: [BoxShadow(
                                        offset: const Offset(-2, 2),
                                        blurRadius: 5,
                                        color: Colors.grey.withOpacity(.5)
                                        )],
                                        borderRadius: BorderRadius.circular(15),
                                ),
                                    child:  Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:  [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                                        child: Image.network(snapshot.data!.docs[index]['ProductImage'],
                                       width: isPortrait?MediaQuery.of(context).size.width*.4:MediaQuery.of(context).size.width*.21
                                       ,
                                          height: isPortrait?MediaQuery.of(context).size.height*.15:MediaQuery.of(context).size.height*.21
                                          ,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(height: 8,),
                                      Text(snapshot.data!.docs[index]['ProductName'],textAlign: TextAlign.center,
                                      style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                                      
                                    ],)),
                        ),
                        
                       
                      ],
                    ),
                              
                  );
                  
                  });
                }
                else {
                  return const Center(child: CircularProgressIndicator(backgroundColor: AppColor.appBarBgColor,));
                }
              
                  }),
                                 Column(
                                   children:  [
                                    const SizedBox(height: 10,),
                                    ListTile(
                                      leading:  Container( 
                                        width: 70,      
                                        height: 70,        
                                               decoration: BoxDecoration(
                                             
                                    border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.2)),
                                    color: Colors.white,
                                    boxShadow: [BoxShadow(
                                    offset: const Offset(-2, 2),
                                    blurRadius: 5,
                                    color: Colors.grey.withOpacity(.5)
                                    )],
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(image: NetworkImage(image),fit: BoxFit.cover)
                                                     ),
                                      ),
                                      title: 
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                       Text(name,textAlign: TextAlign.center,
                                                                style: const TextStyle(fontWeight: FontWeight.bold),),
                                                                Text('$quantity X\n$price'.toString(),textAlign: TextAlign.center,
                                                                style: const TextStyle(color: Colors.grey),),
                                                                Text(incrementPrice.toStringAsFixed(2),textAlign: TextAlign.center,
                                                                style: const TextStyle(fontWeight: FontWeight.bold),),
                                        ],),
                                    ),
                                    const Spacer(),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children:   [
                                                           
                                  Text('Change\n${data.toStringAsFixed(2)}',
                                                               style: TextStyle(color: changeColor,fontWeight: FontWeight.bold,fontSize: 20),),
                                                               SizedBox(
                                                                width: isPortrait?150:200,
                                                                height: 60,
                                                                child: TextField(
                                                                  onChanged: (value) {
                                                                   
                                                                  setState(() {
                                                                  if(double.parse(controller.text)>=incrementPrice){
                                                                  data=double.parse(controller.text)-incrementPrice;
                                                                  changeColor=Colors.green;
                                                                  }
                                                                  else{changeColor=Colors.red;}                                        
                                                                    });
                                                                    
                                                                  },
                                                                  controller: controller,
                                                                  keyboardType: TextInputType.number,
                                                                  decoration:  InputDecoration(label: const Text('Received'),
                                                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                                                                floatingLabelAlignment: FloatingLabelAlignment.center,
                                                                
                                                               
                                                                ),)),
                                                        ],),
                                                        const SizedBox(height: 10,),
                                                        Padding(
                                                          padding: const EdgeInsets.all(15.0),
                                                          child: Row(          
                                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                                           InkWell(
                                                            onTap: (){
                                                              setState(() {
                                                                 data=0.00;
                                                                 incrementPrice=0;
                                                                   quantity=0;
                                                                      totalItems=1;
                                                                      price=0;
                                                                      image='';
                                                                      name='';
                                                                      controller.clear();
                                                              });
                                                            },
                                                             child: Container(
                                                              alignment: Alignment.center,
                                                                                         width: MediaQuery.of(context).size.width*.43,height: 40,
                                                                                                                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                                                                   border: Border.all(
                                                                    width: 2,
                                                                     color: Colors.red,
                                                                   ),
                                                                   ),
                                                                   child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                    children:  const [CircleAvatar(
                                                                    radius: 15,
                                                                    backgroundColor:Colors.red ,
                                                                    child: Icon(Icons.clear,color: Colors.white,)), Text('CLEAR',
                                                                   style: TextStyle(color: Colors.red,),),
                                                                   ],),
                                                                                        
                                                                   ),
                                                           ),
                                                                 InkWell(
                                                                  onTap: (){
                                                                    showDialog(context: context, builder:(context) {
                                                                      return  AlertDialog(
                                                                        actions: [TextButton(onPressed: (){ Navigator.pop(context);}, child:const Text('CANCEL',
                                                                   style: TextStyle(color: Colors.red,),),),
                                                                   TextButton(onPressed: ()async{ 
                                                                    Navigator.pop(context);
                                                                    await screenshotController.capture().then((value) {uploadController.invoiceFireStore(file:value! ,productName: name,id:id );
                                                                    });
                                                                    
                                                                    }, child:const Text('CONFIRM',
                                                                   style: TextStyle(color: Colors.green,),),)
                                                                   ],
                                                                        title: const Text('Confirming'),
                                                                        content: const Text('Do you want to save this invoice?'),);
                                                                        
                                                                    });
                                                                    
                                                                   
                                                                     
                                                                  },
                                                                   child: Container(width: MediaQuery.of(context).size.width*.43,height: 40,decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                                                                   border: Border.all(
                                                                     color: Colors.green,
                                                                     width: 2
                                                                   ),
                                                                   ),
                                                                   child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                    children:   [const CircleAvatar
                                                                   (
                                                                    backgroundColor: Colors.green,
                                                                    radius: 15,
                                                                    child: Icon(Icons.check,color: Colors.white,)), 
                                                                    loading?const Center(child:CircularProgressIndicator(
                                                                      
                                                                      backgroundColor: AppColor.appBarBgColor,) ,):const Text('CONFIRM',textAlign: TextAlign.center,
                                                                   style: TextStyle(color: Colors.green),),
                                                                   ],),
                                                                   ),
                                                                 )
                                                                 ],),
                                                        ),
                                    // Image.asset(Images.cart,width: 200,color: Colors.red,),
                                    // const SizedBox(height: 10,),
                                    // const Text('Empty Cart',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.grey),),
                      
                                   ],
                                 ),           
                           ]),
                 ),
           
              Container(
                height: isPortrait?MediaQuery.of(context).size.height*.13:null,
                 decoration: BoxDecoration(
                        
                                        border: Border.all(color: AppColor.appBarBgColor.withOpacity(.2)),
                                        color: Colors.white,
                                        boxShadow: [BoxShadow(
                                        offset: const Offset(-2, 2),
                                        blurRadius: 5,
                                        color: Colors.grey.withOpacity(.5)
                                        )],
                                        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                                ),
                child: Column(
                  children: [
                         RoundedButtonWidget(text: 'CLEAR', loading: false,press: (){setState(() {
                            color=Colors.purple;
                     incrementPrice=0;
                     quantity=0;
                     totalItems=0;
                });}, color: color,width: isPortrait?340:MediaQuery.of(context).size.width*6,height: 40,),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:  [
                    Column(
                      children:  [
                        const Text('TOTAL',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                         Text(incrementPrice.toStringAsFixed(2),style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                      ],
                    ),
                            const SizedBox(height: 50,child: VerticalDivider(thickness: 2,color: Colors.black,)),
                          
                     Column(
                      children:  [
                        const Text('TOTAL ITEMS',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                         Text(totalItems.toString(),style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                      ],
                    ), 
                            const SizedBox(height: 50,child: VerticalDivider(thickness: 2,color: Colors.black,)),
                          
                    Column(
                      children:  [
                        const Text('QUANTITY',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                         Text(quantity.toString(),style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                      ],
                    ),
                         
                         ],),
                  ],
                ),
              ),
              ],),
            ),
          ),
        ),
        
      );
       },
      
    );
  }
}