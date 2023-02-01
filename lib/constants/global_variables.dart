import 'package:flutter/material.dart';

String uri = 'http://192.168.1.73:3000';
// String uri = 'http://localhost:3000';

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );

  static const mainColor = Color.fromRGBO(65, 105, 225, 1);
  // static const mainColor = Colors.purple;
  static const backgroundColour = Color.fromRGBO(242, 244, 255, 1);
  static const eventListColor = Color.fromRGBO(0, 191, 225, 1);
  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;
}
