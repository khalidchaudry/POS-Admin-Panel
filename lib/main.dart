import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simplecashier/provider/theme_provider.dart';
import 'package:simplecashier/view/routes/route_name.dart';
import 'package:simplecashier/view/utils/app_colors.dart';

import 'view/routes/routes.dart';
import 'view/screens/theme/dark_theme.dart';
import 'view/screens/theme/light_theme.dart';


Future main() async{
  
  WidgetsFlutterBinding.ensureInitialized();
  //  EasyLocalization.ensureInitialized();
  
  SharedPreferences sp=await SharedPreferences.getInstance();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(apiKey: 'AIzaSyBxixSwX0dOWs2kd3pY4xkfGNHjE8ZuYaE', appId: "1:729150149298:web:a3f068823f42433eea2fab", messagingSenderId: "729150149298", projectId: "pos-admin-pannel")
    );
    
  }else{
    
  await Firebase.initializeApp();
  }
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_)=>ThemeProvider(sp:sp)),
    ],
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: AppColor.appBarBgColor));
    return    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Cashier',
       theme: Provider.of<ThemeProvider>(context).darkTheme ? dark : light,

      // localizationsDelegates:context.localizationDelegates,
      // supportedLocales: context.supportedLocales,
      // locale: context.locale,
      
        onGenerateRoute: Routes.routeGenerator,
    );
  }
}
