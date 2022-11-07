import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../global_widgets/global_widgets.dart';
import '../../../utils/utils.dart';

class AddInventoryItemsScreen extends StatefulWidget {   
  @override
  State<AddInventoryItemsScreen> createState() => _AddInventoryScreenState();
}
class _AddInventoryScreenState extends State<AddInventoryItemsScreen> {
bool loading =false;
TextEditingController productNameController=TextEditingController();
TextEditingController stockController=TextEditingController();
TextEditingController companyNameController=TextEditingController();

Color color=Colors.green;
bool isButtonActive=true;

  @override
  void dispose() {
    productNameController.dispose();
    stockController.dispose();
    companyNameController.dispose();
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
        title:  const Text('Add Inventory',style: AppColor.appBarTextStyle,),backgroundColor: AppColor.appBarBgColor,),
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
          hintText: 'Stock Quantity', boolCheck: stockBool, controller: stockController),
         sizedBoxheight,
         TextFieldWidget(
           keyboardType: TextInputType.text,
          moveNextField: TextInputAction.done,
          hintText: 'Company Name', boolCheck: companyBool, controller: companyNameController),
         sizedBoxheight,
          SizedBox(
            width: double.infinity,
            child: NeumorphicButtonWidget(isCheck: addBtnBool, press: ()async{
              if (filePicker!=null&&productNameController.text.isNotEmpty && stockController.text.isNotEmpty && 
              companyNameController.text.isNotEmpty) {
    setState(() {
      loading=true;
    });
    
await inventoryController.stock(
productName: productNameController.text.toString(),
   stock:stockController.text.toString(),
    companyName: companyNameController.text.toString(),
      file: filePicker,
      );
      setState(() {
        loading=false;
      });
              }else{
                 flushBarErrorMessage('Please fill all fields', context);
              }
               
            }, color: AppColor.navBarBxColor, child:loading?const Center(child: CircularProgressIndicator(backgroundColor: AppColor.appBarBgColor,)):const Text('UPLOAD',textAlign: TextAlign.center,style: TextStyle(color: Colors.white),)),
          ),
         
          
        ],),),
      )),
    );
  }

}