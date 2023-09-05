import 'package:flutter/material.dart';
import 'package:timelineandprojectmanagementapp/constants/global_variables.dart';

//category card
class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required  this.categoryText,
    required  this.isActive,
  }) : super(key: key);

  final String categoryText;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: !isActive
              ? const Color.fromRGBO(221, 229, 249, 1)//background color of unselected
              : GlobalVariables.mainColor,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Text(
          categoryText,
          style: TextStyle(
            color: !isActive ? Colors.blue : Colors.white,//color of text
            fontSize: 14,
          ),
        ));
  }
}