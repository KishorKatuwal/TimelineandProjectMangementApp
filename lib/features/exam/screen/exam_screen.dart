import 'package:flutter/material.dart';
import 'package:timelineandprojectmanagementapp/common/widgets/custom_button.dart';
import 'package:timelineandprojectmanagementapp/features/exam/services/exam_services.dart';

import '../../../constants/global_variables.dart';

class ExamScreen extends StatefulWidget {
  static const String routeName = '/exam-screen';

  const ExamScreen({Key? key}) : super(key: key);

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  final ExamServices examServices = ExamServices();

  List<List<dynamic>> _data = [];

  void gettingData() async {
    _data = await examServices.loadListFromCSV(context);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettingData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exam and Coursework Details"),
      ),
      body: _data.isNotEmpty
          ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _data.length,
                      itemBuilder: (_, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          elevation: 4,
                          margin: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    color: GlobalVariables.mainColor),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    _data[index][0],
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        letterSpacing: 1.2),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text("Module Code: ${_data[index][1]}",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500)),
                                    const SizedBox(height: 8.0),
                                    Text("Assessment Type: ${_data[index][4]}",
                                        style: const TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500)),
                                    const SizedBox(height: 8.0),
                                    Text("Faculty: ${_data[index][3]}",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500)),
                                    const SizedBox(height: 8.0),
                                    Text("Weightage: ${_data[index][5]}",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500)),
                                    const SizedBox(height: 8.0),
                                    Text("Submission Week: ${_data[index][6]}",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500)),
                                    const SizedBox(height: 8.0),
                                    Text("Date: ${_data[index][7]}",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                ),
              ],
            )
          : const Center(
              child: Text(
                "You don't have any Exam or Assessments",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
    );
  }
}
