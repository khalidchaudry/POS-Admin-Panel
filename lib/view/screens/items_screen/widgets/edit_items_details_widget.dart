import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:simplecashier/provider/product_provider.dart';
import '../../../global_widgets/global_widgets.dart';
import '../../../utils/utils.dart';


class EditItemsScreen extends StatefulWidget {
   const EditItemsScreen({super.key, required this.productName, required this.productPrice,required this.desc, required this.image, required this.id, required this.discount});
   final String productName,desc,image;
   final double productPrice,discount;
   final String id;

  @override
  State<EditItemsScreen> createState() => _EditItemsScreenState();
}

class _EditItemsScreenState extends State<EditItemsScreen> {
final fireStore=FirebaseFirestore.instance.collection('users');
 Uint8List? image;
bool loading =false;
 String code='';

TextEditingController? productNameController;
TextEditingController? priceController;
TextEditingController? descController;
TextEditingController? barcodeController;
TextEditingController? discountController;

Color color=Colors.green;
bool isButtonActive=true;

@override
  void initState() {
   productNameController=TextEditingController(text: widget.productName);
   priceController=TextEditingController(text: widget.productPrice.toString());
   descController=TextEditingController(text: widget.desc.toString());
      discountController=TextEditingController(text: widget.discount.toString());

super.initState();
  }
  @override
  void dispose() {
    productNameController?.dispose();
    priceController?.dispose();
    descController?.dispose();
    barcodeController?.dispose();
    discountController?.dispose();
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
  Widget build(BuildContext context) {
    ProductProvider editItemProvider=Provider.of(context);
    final size=MediaQuery.of(context).size;
    final sizedBoxheight=SizedBox(height: size.height*.02,);
    bool nameField=false;
    bool isImageValue=false;
    bool priceBool=false;
     bool descBool=false;
     bool addBtnBool=false;
      bool barcodeBool=false;
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back),color: Colors.green,),
        elevation: 
        .5,
        title:  const Text(AppString.appBarEditItem,style: AppColor.appBarTextStyle,),backgroundColor: AppColor.appBarBgColor,),
      body: SafeArea(child: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(20),child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            pickImageMethod(isImageValue, context, size),
         sizedBoxheight,
         TextFieldWidget(
          keyboardType: TextInputType.text,
          moveNextField: TextInputAction.next,
          hintText: widget.productName, boolCheck: nameField, controller: productNameController!),
          sizedBoxheight,
        
         TextFieldWidget(
            keyboardType: TextInputType.number,
          moveNextField: TextInputAction.next,
          hintText: widget.productPrice.toString(), boolCheck: priceBool, controller: priceController!),
         sizedBoxheight,
         TextFieldWidget(
           keyboardType: TextInputType.text,
          moveNextField: TextInputAction.next,
          hintText: widget.desc, boolCheck: descBool, controller: descController!),
         sizedBoxheight,
         const Text('Optional',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                  const SizedBox(height: 5,),
         TextFieldWidget(
           keyboardType: TextInputType.number,
          moveNextField: TextInputAction.done,
          hintText: widget.discount.toString(), boolCheck: descBool, controller: discountController!),
         sizedBoxheight,
         sizedBoxheight,
          SizedBox(
            width: double.infinity,
            child: NeumorphicButtonWidget(isCheck: addBtnBool, press: ()async{
              if (productNameController!.text.isNotEmpty && priceController!.text.isNotEmpty && 
              descController!.text.isNotEmpty && barcodeController!.text.isNotEmpty) {
                
    setState(() {
      loading=true;
    });
await uploadController.updateFireStore(
productName: productNameController!.text.toString(),
   productPrice:priceController!.text.toString(),
    productDesc: descController!.text.toString(),
     productDiscount: discountController!.text.toString(),
      file: filePicker,
      id: widget.id.toString(),
      );
      setState(() {
        loading=false;
      });
  
              }else{
                 flushBarErrorMessage('Please fill all fields', context);
              }
               
            }, 
            color: AppColor.navBarBxColor, 
            child:loading?const Center(child: CircularProgressIndicator(backgroundColor: AppColor.appBarBgColor,)):
            const Text('UPDATE',textAlign: TextAlign.center,style: TextStyle(color: Colors.white),)),
          ),
         
          
        ],),),
      )),
    );
  }

  }
