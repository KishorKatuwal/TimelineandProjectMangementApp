import 'package:flutter/material.dart';
import '../../../constants/global_variables.dart';


class ProgressCard extends StatelessWidget {
  ProgressCard(
      {Key? key, required this.ProjectName, required this.CompletedPercent})
      : super(key: key);
  late String ProjectName;
  late int CompletedPercent;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 3.0,
            margin: const EdgeInsets.only(top: 10),
            height: 49 * 0.01 * CompletedPercent,
            decoration: BoxDecoration(
              // color: Color.fromARGB(255, 123, 0, 245),
              color: GlobalVariables.mainColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Expanded(
            child: Container(
              height: 70,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    // color: Color.fromARGB(255, 123, 0, 245),
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
                    const Text(
                      "2 days ago",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
                Expanded(child: Container()),
                const Icon(
                  Icons.more_vert_outlined,
                  color: Colors.grey,
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}