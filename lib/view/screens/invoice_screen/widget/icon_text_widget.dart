import 'package:flutter/material.dart';

class IconTextWidget extends StatelessWidget {
  const IconTextWidget({super.key, required this.text, required this.iconData});
final String text;
final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Icon(iconData),
      Text(text),
    ],);
  }
}