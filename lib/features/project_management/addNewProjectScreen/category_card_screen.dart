import 'package:flutter/material.dart';
import '../../../constants/global_variables.dart';


class Categorcard extends StatelessWidget {
  const Categorcard({
    Key? key,
    required String this.CategoryText,
    required bool this.isActive,
  }) : super(key: key);
  final String CategoryText;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: !this.isActive
              ? Color.fromRGBO(221, 229, 249, 1)
              // : Color.fromRGBO(130, 0, 255, 1),
              : GlobalVariables.mainColor,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Text(
          this.CategoryText,
          style: TextStyle(
            color: !this.isActive ? Colors.grey : Colors.white,
            fontSize: 12,
          ),
        ));
  }
}