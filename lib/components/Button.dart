import 'package:flutter/material.dart';

materialButton({
  double width,
  String text,
  IconData icon,
  List<double> padding = const [0, 0, 0, 0],
  VoidCallback onPressed,
  Color color = Colors.blue
}) {
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