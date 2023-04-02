import 'package:flutter/material.dart';
import '../../../constants/global_variables.dart';


class Categorycard extends StatelessWidget {
  const Categorycard({
    Key? key,
    required String this.CategoryText,
    required bool this.isActive,
  }) : super(key: key);
  final String CategoryText;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: !isActive
              ? const Color.fromRGBO(221, 229, 249, 1)
              // : Color.fromRGBO(130, 0, 255, 1),
              : GlobalVariables.mainColor,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Text(
          CategoryText,
          style: TextStyle(
            color: !isActive ? Colors.grey : Colors.white,
            fontSize: 12,
          ),
        ));
  }
}