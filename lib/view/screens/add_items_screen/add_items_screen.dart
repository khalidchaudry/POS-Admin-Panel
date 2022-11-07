import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:simplecashier/view/utils/utils.dart';

import '../../global_widgets/global_widgets.dart';

class AddItemsScreen extends StatefulWidget {
   const AddItemsScreen({super.key});

  @override
  State<AddItemsScreen> createState() => _AddItemsScreenState();
}

class _AddItemsScreenState extends State<AddItemsScreen> {
  
final fireStore=FirebaseFirestore.instance.collection('users');
bool loading =false;
Color color=Colors.green;
// Controllers
TextEditingController productNameController=TextEditingController();
TextEditingController priceController=TextEditingController();
TextEditingController descController=TextEditingController();
TextEditingController barcodeController=TextEditingController();
TextEditingController discountController=TextEditingController();
  @override
  void dispose() {
    productNameController.dispose();
    priceController.dispose();
    descController.dispose();
    barcodeController.dispose();
    discountController.dispose();
    super.dispose();
  }

 // Image Picker
String fileName='';
 Uint8List? filePicker;
 selectFile() async {
    FilePickerResult? fileResult = await FilePicker.platform.pickFiles();
    if (fileResult != null) {
      setState(() {
        filePicker = fileResult.files.first.bytes;
        fileName=fileResult.files.first.name;
      });
    }
    debugPrint(fileName.toString());
  }
 NeumorphicButtonWidget pickImageMethod(bool isImageValue, BuildContext context, Size size) {
  bool galleryValue=false;
    return NeumorphicButtonWidget(
           color: Colors.transparent,
       isCheck: isImageValue,
          press: () { 
          },
           child:NeumorphicButtonWidget(isCheck: galleryValue,
                   color: Colors.transparent,
                  press:(){
                    selectFile();
                  },
          child: Column(
            children: [
 
 filePicker==null?
 Image.asset(Images.pickImage,height: 150,width: double.infinity,):
 Image.memory(filePicker!,height: 150,width: double.infinity),
 const SizedBox(height: 5,),
 const Text('Add your company logo',style: TextStyle(color:Colors.grey,)),
const SizedBox(height: 5,),
 const Text('Best image dimensions is 320x650 px',style: TextStyle(color:Colors.grey,))
            ],
          ),
    ));
  }
  @override
  Widget build(BuildContext context) =>OrientationBuilder(builder: (context, orientation) {
    final isPortrait=orientation==Orientation.portrait;
     final size=MediaQuery.of(context).size;
    final sizedBoxheight=isPortrait?SizedBox(height: size.height*.02,):SizedBox(height: size.height*.04);
    bool nameField=false;
    bool isImageValue=false;
    bool priceBool=false;
     bool descBool=false;
     bool addBtnBool=false;
      bool barcodeBool=false;
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 
        .5,
        title:  const Text(AppString.appBarAddItem,style: AppColor.appBarTextStyle,),backgroundColor: AppColor.appBarBgColor,),
      body: SafeArea(child: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(20),child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            pickImageMethod(isImageValue, context, size),
         sizedBoxheight,
         TextFieldWidget(
          keyboardType: TextInputType.text,
          moveNextField: TextInputAction.next,
          hintText: 'Product Name', boolCheck: nameField, controller: productNameController),
          sizedBoxheight,
        
         TextFieldWidget(
            keyboardType: TextInputType.number,
          moveNextField: TextInputAction.next,
          hintText: 'Product Price', boolCheck: priceBool, controller: priceController),
         sizedBoxheight,
         TextFieldWidget(
           keyboardType: TextInputType.text,
          moveNextField: TextInputAction.next,
          hintText: 'Product Description', boolCheck: descBool, controller: descController),
         sizedBoxheight,
    //       NeumorphicButtonWidget(
    //         isCheck: barcodeBool,
    //         press: (){
    //           setState(() {
    //             barcodeBool=!barcodeBool;
    //           });
    //         },
    //         color: Colors.transparent,
    //         child: TextField(  
    //       keyboardType: TextInputType.number,
    //         controller: barcodeController,
    //         textInputAction: TextInputAction.next,
    //           decoration:   InputDecoration(hintText: 'Product Barcode',           
    //           border: InputBorder.none,
    //           suffixIcon: 
    //           TextButton(onPressed:(){  
    //             Navigator.push(context, MaterialPageRoute(builder: (_)=>MobileScanner(
    //       allowDuplicates: false,
    //       controller: MobileScannerController(
    //         facing: CameraFacing.back, torchEnabled: true),
    //       onDetect: (barcode, args) {
    //         if (barcode.rawValue == null) {
    //           flushBarErrorMessage(barcode.rawValue.toString(), context);
    //           debugPrint('Failed to scan Barcode');
    //         } else {
    //         code = barcode.rawValue!;
    //         setState(() {
    //           Navigator.pop(context);
    //  barcodeController.text=code;
    //         });
    //       flushBarErrorMessage('Barcode found: $code', context);
    //           debugPrint('Barcode found! $code');
    //         }
    //       }),));
    //           }, 
    //            child:  Image.asset(Images.qr,width: 30,height:30))
    //           ),
              
    //           ),
    //         ),
                          //  const SizedBox(height: 7,),

         const Text('Optional',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                  const SizedBox(height: 5,),
         TextFieldWidget(
           keyboardType: TextInputType.number,
          moveNextField: TextInputAction.done,
          hintText: 'Discount in %', boolCheck: descBool, controller: discountController),
         sizedBoxheight,
          SizedBox(
            width: double.infinity,
            child: NeumorphicButtonWidget(isCheck: addBtnBool, press: ()async{
              SystemChannels.textInput.invokeMapMethod('TextInput.hide');
              if (productNameController.text.isNotEmpty && priceController.text.isNotEmpty && 
              descController.text.isNotEmpty) {
                 setState(() {
      loading=true;
    });
await uploadController.fireStore(
  productName: productNameController.text,
   productPrice: priceController.text,
    productDesc: descController.text,
     productDiscount:discountController.text,
      file: filePicker
      );
      setState(() {
        loading=false;
      });
              }else{
                 flushBarErrorMessage('Please fill all fields', context);
              }
                color=Colors.transparent;
               
            }, color: AppColor.navBarBxColor, child:loading?const Center(child: CircularProgressIndicator(backgroundColor: AppColor.appBarBgColor,)):const Text('ADD',textAlign: TextAlign.center,style: TextStyle(color: Colors.white),)),
          ),
         
          
        ],),),
      )),
    );
}); 


  }

 