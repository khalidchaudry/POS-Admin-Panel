import 'package:flutter/material.dart';

import 'neumorphic_button_widget.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({super.key, required this.hintText, required this.boolCheck, required this.controller, required this.keyboardType, required this.moveNextField});
final String hintText;
final bool boolCheck;
final TextInputType keyboardType;
final TextInputAction moveNextField;
final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return  NeumorphicButtonWidget(
            isCheck: boolCheck,
            press: (){},
            color: Colors.transparent,
            child: TextField(
          
          keyboardType: keyboardType,
            controller: controller,

            textInputAction: moveNextField,
              decoration:  InputDecoration(hintText: hintText,
        
              border: InputBorder.none
              
              ),
              
              ),
            );
  }
}