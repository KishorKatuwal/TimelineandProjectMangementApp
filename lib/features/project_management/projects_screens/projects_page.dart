import 'package:flutter/material.dart';
import 'package:provider/Provider.dart';
import 'package:timelineandprojectmanagementapp/constants/global_variables.dart';
import 'package:timelineandprojectmanagementapp/features/project_management/addNewProjectScreen/add_new_project.dart';
import 'package:timelineandprojectmanagementapp/features/project_management/projects_screens/progress_card.dart';
import 'package:timelineandprojectmanagementapp/features/project_management/tasks_screen/task_page.dart';
import '../../../providers/user_provider.dart';
import 'overview_scroll.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {


  @override
  Widget build(BuildContext context) {
    final userName = Provider.of<UserProvider>(context).user.name;
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          color: const Color.fromRGBO(242, 244, 255, 1),
          padding: const EdgeInsets.all(0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.menu_rounded,
                    size: 30,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      // color: Color.fromARGB(255, 123, 0, 245),
                      color: GlobalVariables.mainColor,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.add,color: Colors.white,),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddNewTask()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text:  TextSpan(
                      children: [
                        const TextSpan(
                          text: "Hello,",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                          ),
                        ),
                         TextSpan(
                          text: userName,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                  const Text(
                    "Stay on schedule, stay on track with our app.",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 0, bottom: 0, left: 20, right: 0),
              child: OverView(),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Progress",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  ProgressCard(ProjectName: "Project", CompletedPercent: 30, remainingDays: 5,),
                  ProgressCard(ProjectName: "Project", CompletedPercent: 50, remainingDays: 5,),
                  ProgressCard(ProjectName: "Project", CompletedPercent: 30 ,remainingDays: 5,),
                  ProgressCard(ProjectName: "Project", CompletedPercent: 30, remainingDays: 5,),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
