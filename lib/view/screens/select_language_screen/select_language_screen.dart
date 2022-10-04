import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simplecashier/view/screens/home_screen/home_screen.dart';
import 'package:simplecashier/view/utils/app_colors.dart';

class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({super.key});

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: AppColor.appBarBgColor));
    return  Scaffold(
      body: SafeArea(child: Padding(padding: const EdgeInsets.all(15),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
          const Text('Select Language',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          const SizedBox(height: 20,),
          TextButton(onPressed: (){
            setState(() {
              // context.setLocale(const Locale("ar","SA"));
            });
            Navigator.push(context, MaterialPageRoute(builder: (_)=>const HomeScreen()));
          }, child:        const Text('العربية',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
          
),
          TextButton(onPressed: (){setState(() {
              // context.setLocale(const Locale("en","US"));
            });
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>const HomeScreen()));

            }, child:        const Text('English',style: TextStyle(fontWeight: FontWeight.bold,),),),


        ],),
      ),
      )),
    );
  }
}