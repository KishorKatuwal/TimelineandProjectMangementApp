import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../constants/global_variables.dart';

//projects on dashboard
class OverviewCard extends StatefulWidget {
  final String projectName;
  final int index;
  final int remainingTasks;
  final String dueDate;

  const OverviewCard(
      {Key? key,
      required this.projectName,
      required this.index,
      required this.remainingTasks,
      required this.dueDate})
      : super(key: key);

  @override
  State<OverviewCard> createState() => _OverviewCardState();
}

class _OverviewCardState extends State<OverviewCard> {
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
              Text(
                "Project ${widget.index + 1}",
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          Text(
            widget.projectName,
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.dueDate!="noDueDate"?[
              Text(
                "Remaining Tasks: ${widget.remainingTasks}",
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
              Text(
                "Due Date: ${widget.dueDate}",
                style: const TextStyle(color: Colors.white, fontSize: 15),
              )
            ]:[
              const Text(
                "Status: Completed",
                style:  TextStyle(color: Colors.white, fontSize: 15),
              )
            ],
          ),
        ],
      ),
    );
  }
}
