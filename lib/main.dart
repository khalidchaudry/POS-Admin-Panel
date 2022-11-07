import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simplecashier/provider/provider.dart';
import 'package:simplecashier/view/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:simplecashier/view/screens/theme/dark_theme.dart';
import 'package:simplecashier/view/utils/app_colors.dart';
import 'view/screens/theme/light_theme.dart';

Future backgroundHandler(RemoteMessage message)async{
  debugPrint('Handling background Message:${message.messageId}');
}
  String uid='';
Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sp=await SharedPreferences.getInstance();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
       apiKey: "AIzaSyBxixSwX0dOWs2kd3pY4xkfGNHjE8ZuYaE",
      authDomain: "pos-admin-pannel.firebaseapp.com",
      projectId: "pos-admin-pannel",
      storageBucket: "pos-admin-pannel.appspot.com",
      messagingSenderId: "729150149298",
      appId: "1:729150149298:web:219f3a9d103e702eea2fab",
      measurementId: "G-EVFR4HVDPB"
       )
    );
    await FirebaseMessaging.instance.getInitialMessage().then((message) {
    debugPrint('...........Firebase Cloud Messaging...........');
    if (message!=null) {
      debugPrint('New Notification detected');
    }else{
      
    }
  });
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  }else{
    await Firebase.initializeApp();
  }
  runApp
  (MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_)=>ThemeProvider(sp:sp)),
      ChangeNotifierProvider(create: (_)=>ProductProvider()),
      ChangeNotifierProvider(create: (context)=>CartProvider())
    ],
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: AppColor.navigationRailBgColor));
    return    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KB',
       themeMode: Provider.of<ThemeProvider>(context).themeMode,
       theme: light,
       darkTheme: dark,
       home: const BottomNavBar(),
        // onGenerateRoute: Routes.routeGenerator,
    );
  }
}