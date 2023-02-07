import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  final bool loader;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.loader=true,
    this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: loader?onTap:null,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        primary: color,
      ),
      child: loader?Text(text, style: const TextStyle(
       fontSize: 18,
      ),):const CircularProgressIndicator(color: Colors.white,),
    );
  }
}
