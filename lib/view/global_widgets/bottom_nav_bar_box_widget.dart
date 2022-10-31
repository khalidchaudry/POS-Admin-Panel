import 'package:flutter/material.dart';
import 'package:simplecashier/view/utils/app_colors.dart';
class BottomNavBarBoxWidget extends StatelessWidget {
  const BottomNavBarBoxWidget({super.key, required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
    
    return Container(
      width: 50,
          height: 50,
          decoration:   BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColor.navBarBxColor,
          boxShadow:   const [
             BoxShadow(
            offset:Offset(-1, -1),
            blurRadius: 1,
           
            color: Colors.black,
         
      
          ),
            BoxShadow(
            offset:Offset(1, 1),
            blurRadius: 1,
            color:Colors.black,
           
          )
          ]
          ),
          child: Image.asset(image,color: Colors.white,),
    );
  }
}