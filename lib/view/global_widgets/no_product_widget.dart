import 'package:flutter/material.dart';
class NoProductWidget extends StatelessWidget {
  const NoProductWidget({super.key, required this.image});
 final String image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(image),
      ),
    );
  }
}