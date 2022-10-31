import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicButtonWidget extends StatelessWidget {
  const NeumorphicButtonWidget({super.key, required this.child, required this.isCheck, required this.press, required this.color});
final Widget child;
final bool isCheck;
final Color color;
final Function() press;
  @override
  Widget build(BuildContext context) {
    return   NeumorphicButton(
         onPressed: press,
         
                style: NeumorphicStyle(
                  depth:isCheck?-30:1,
                  color: color,
                  shape: NeumorphicShape.concave,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                  border: const NeumorphicBorder()
                ),
                padding: const EdgeInsets.all(15.0),
                child:child ,
                );
  }
}