import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final double width;
  final String text;
  final IconData icon;
  final List<double> padding;
  final VoidCallback onPressed;
  final Color color;
  Button({
    Key key,
    this.width,
    this.text,
    this.icon,
    this.padding = const [0, 0, 0, 0],
    this.onPressed,
    this.color = Colors.blue
  }): super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.only(
        top: padding[0],
        right: padding[1],
        bottom: padding[2],
        left: padding[3]
      ),
      child: MaterialButton(
        color: color,
        child: icon != null ? Icon(icon) : Text(text),
        onPressed: onPressed
      )
    );
  }
}