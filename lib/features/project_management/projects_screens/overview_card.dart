import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../constants/global_variables.dart';

class OverviewCard extends StatelessWidget {
  const OverviewCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(left: 0, right: 20, top: 5, bottom: 5),
      width: 180,
      height: 250,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        // color: GlobalVariables.mainColor,
          color: const Color.fromRGBO(112, 141, 246, 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                margin: const EdgeInsets.only(right: 10),
                decoration: const BoxDecoration(
                  // color: Color.fromARGB(255, 123, 0, 245),
                  color: GlobalVariables.mainColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: const Icon(Icons.assignment, color: Colors.white),
              ),
              const Text(
                "project",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
         const  Text(
            "Back End Development",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          Text(
            DateFormat.MMMd().format((DateTime.now())),
            style: const TextStyle(color: Colors.white, fontSize: 15),
          )
        ],
      ),
    );
  }
}