import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simplecashier/view/utils/app_colors.dart';

import '../../../provider/theme_provider.dart';
class SettingsScreen extends StatelessWidget {
   SettingsScreen({super.key});
   bool isClicked=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: AppBar(title: const Text('Settings'),
      centerTitle: true,
      backgroundColor: AppColor.appBarBgColor,
    
      ),
      body:SwitchListTile(

        value: Provider.of<ThemeProvider>(context).darkTheme,
        activeColor: Colors.green,
                  onChanged: (bool isActive) =>Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
                  title: Provider.of<ThemeProvider>(context).darkTheme?const Text('Light Theme',
                  style: TextStyle(color: Colors.white),
                      ):const Text('Dark Theme',
                      ))
      
    );
  }
}