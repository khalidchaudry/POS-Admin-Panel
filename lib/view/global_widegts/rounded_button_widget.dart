import 'package:flutter/material.dart';

class RoundedButtonWidget extends StatelessWidget {
  const RoundedButtonWidget({super.key,required this.text, required this.press, required this.color, required this.width, required this.height, required this.loading});
final String text;
final Function() press;
final Color color;
final double width;
final double height;
final  bool loading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      
      style: ElevatedButton.styleFrom(backgroundColor:color,minimumSize:  Size(width, height),shape: const StadiumBorder()),
      onPressed: press,
      child: loading?const Center(child: CircularProgressIndicator()):Text(text),);
  }
}