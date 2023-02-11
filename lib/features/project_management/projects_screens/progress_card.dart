import 'package:flutter/material.dart';
import '../../../constants/global_variables.dart';

class ProgressCard extends StatelessWidget {
  ProgressCard(
      {Key? key,
      required this.ProjectName,
      required this.CompletedPercent,
      required this.remainingDays})
      : super(key: key);
  late String ProjectName;
  late int CompletedPercent;
  late int remainingDays;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: GlobalVariables.mainColor,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: const Icon(Icons.assignment, color: Colors.white),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      ProjectName,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      remainingDays > 0
                          ? "$remainingDays days remaining!"
                          : "Project on due!",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Expanded(child: Container()),
                const Icon(Icons.more_vert),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            width: double.infinity,
            height: 5,
            decoration: BoxDecoration(
              color: GlobalVariables.mainColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.bottomLeft,
              widthFactor: CompletedPercent / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: GlobalVariables.mainColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
