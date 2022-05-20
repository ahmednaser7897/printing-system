import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final Function onPress;
  final Widget child;
  final Color? textColor;
  final Color buttonColor;
  final double buttonHeight;
  final double buttonMinWidth;
  final double borderRadius;

  const DefaultButton({
    Key? key,
    required this.onPress,
    required this.buttonColor,
    required this.child,
    required this.buttonHeight,
    required this.buttonMinWidth,
    this.borderRadius = 10,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: MaterialButton(
        minWidth: buttonMinWidth,
        height: buttonHeight,
        onPressed: () {
          onPress();
        },
        child: child,
      ),
    );
  }
}
