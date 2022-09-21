import 'package:flutter/material.dart';

class RoundedButtonWidget extends StatelessWidget {
  const RoundedButtonWidget({super.key, required this.text, required this.press, required this.color});
final String text;
final Function() press;
final Color color;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:press ,
      
      style: ElevatedButton.styleFrom(backgroundColor: color,minimumSize: const Size(160, 40),shape: const StadiumBorder()),
      child: Text(text),);
  }
}