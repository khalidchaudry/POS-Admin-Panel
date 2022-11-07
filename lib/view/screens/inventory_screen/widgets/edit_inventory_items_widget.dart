import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../global_widgets/global_widgets.dart';
import '../../../utils/utils.dart';


class EditInventoryItemsScreen extends StatefulWidget {
   const EditInventoryItemsScreen({super.key, required this.productName, required this.stock,required this.companyName,   required this.image, required this.id});
   final String productName,companyName,image;
   final int stock;
   final String id;
  @override
  State<EditInventoryItemsScreen> createState() => _EditInventoryScreenState();
}
class _EditInventoryScreenState extends State<EditInventoryItemsScreen> {
final fireStore=FirebaseFirestore.instance.collection('users');
bool loading =false;
 String code='';
 Uint8List? image;
TextEditingController? productNameController;
TextEditingController? stockController;
TextEditingController? companyNameController;


Color color=Colors.green;
bool isButtonActive=true;

@override
  void initState() {
   productNameController=TextEditingController(text: widget.productName);
   stockController=TextEditingController(text: widget.stock.toString());
   companyNameController=TextEditingController(text: widget.companyName.toString());

super.initState();
  }
  @override
  void dispose() {
    productNameController?.dispose();
    stockController?.dispose();
    companyNameController?.dispose();
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
    final size=MediaQuery.of(context).size;
    final sizedBoxheight=SizedBox(height: size.height*.02,);
    bool nameField=false;
    bool isImageValue=false;
    bool stockBool=false;
     bool companyBool=false;
     bool addBtnBool=false;
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back),color: Colors.green,),
        elevation: 
        .5,
        title:  const Text('Edit Inventory',style: AppColor.appBarTextStyle,),backgroundColor: AppColor.appBarBgColor,),
      body: SafeArea(child: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(20),child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
        pickImageMethod(isImageValue, context, size),
         sizedBoxheight,
         TextFieldWidget(
          keyboardType: TextInputType.text,
          moveNextField: TextInputAction.next,
          hintText: 'Product Name', boolCheck: nameField, controller: productNameController!),
          sizedBoxheight,
        
         TextFieldWidget(
            keyboardType: TextInputType.number,
          moveNextField: TextInputAction.next,
          hintText: 'Stock Quantity'.toString(), boolCheck: stockBool, controller: stockController!),
         sizedBoxheight,
         TextFieldWidget(
           keyboardType: TextInputType.text,
          moveNextField: TextInputAction.next,
          hintText: 'Company Name', boolCheck: companyBool, controller: companyNameController!),
         sizedBoxheight,
          SizedBox(
            width: double.infinity,
            child: NeumorphicButtonWidget(isCheck: addBtnBool, press: ()async{
             
                
    setState(() {
      loading=true;
    });
await inventoryController.updateStock(
productName: productNameController!.text.toString(),
   stock:stockController!.text.toString(),
    companyName: companyNameController!.text.toString(),
      file: filePicker,
      id: widget.id.toString()
      );
      setState(() {
        loading=false;
      });
               
            }, color: AppColor.navBarBxColor, child:loading?const Center(child: CircularProgressIndicator(backgroundColor: AppColor.appBarBgColor,)):const Text('UPDATE',textAlign: TextAlign.center,style: TextStyle(color: Colors.white),)),
          ),
         
          
        ],),),
      )),
    );
  }

}