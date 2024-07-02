import 'package:flutter/material.dart';

class SubtitleTextWidget extends StatelessWidget {
  const SubtitleTextWidget({super.key, required this.label,  this.fontSize=18, this.fontWeight=FontWeight.normal, this.color, this.textDecoration=TextDecoration.none,  this.fontStyle=FontStyle.normal, required this.textDecorations});
final String label;
final double fontSize ;
final FontWeight ? fontWeight;
final Color ? color;
final TextDecoration ? textDecoration;
final FontStyle  fontStyle;
final TextDecoration  textDecorations;
  @override
  Widget build(BuildContext context) {
    return  Text(
      label,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
        fontStyle: fontStyle,
        decoration: textDecoration,

      ),
    );
  }
}
