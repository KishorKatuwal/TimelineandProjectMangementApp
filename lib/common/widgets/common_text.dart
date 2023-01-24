import 'package:flutter/material.dart';

class CommonText extends StatefulWidget {
  final String headText;
  final String text;
  final double fontSize;
  final bool colorBool;

  const CommonText(
      {Key? key,
      required this.headText,
      required this.text,
      this.colorBool = false,
      this.fontSize = 16})
      : super(key: key);

  @override
  State<CommonText> createState() => _CommonTextState();
}

class _CommonTextState extends State<CommonText> {
  @override
  Widget build(BuildContext context) {
    return  RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: widget.headText,
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: widget.fontSize + 2,
                letterSpacing: 1.5),
          ),
          TextSpan(
            text: widget.text,
            style: TextStyle(
                color: widget.colorBool ? Colors.red : Colors.black87,
                fontSize: widget.fontSize,
                fontWeight: FontWeight.w300,
                letterSpacing: 0.5,
                wordSpacing: 2),
          ),
        ],
      ),
    );

  }
}
