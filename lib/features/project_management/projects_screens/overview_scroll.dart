import 'package:flutter/material.dart';
import 'package:timelineandprojectmanagementapp/features/project_management/services/projects_service.dart';
import '../models/project_management_model.dart';
import 'overview_card.dart';

class OverView extends StatefulWidget {
  const OverView({Key? key}) : super(key: key);

  @override
  State<OverView> createState() => _OverViewState();
}

class _OverViewState extends State<OverView> with TickerProviderStateMixin {
  late TabController tabController;
  final ProjectServices projectServices = ProjectServices();
  List<ProjectDataModel> projectDataModel = [];
  List<ProjectDataModel> completedProjects = [];

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    super.initState();
    getData();
    getCompletedProjects();
  }

  void getData() async {
    projectDataModel = await projectServices.fetchAllProducts(context);
    setState(() {});
  }

  void getCompletedProjects()async{
    completedProjects = await projectServices.getCompletedProjects(context);
    setState(() {});
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            controller: tabController,
            labelColor: Colors.black,
            isScrollable: true,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(0),
            unselectedLabelColor: Colors.grey.shade400,
            tabs: const [
              Tab(
                text: "Projects",
              ),
              Tab(
                text: "Pending Projects",
              ),
              Tab(
                text: "Completed Projects",
              ),
            ],
          ),
          SizedBox(
            height: 250,
            width: double.maxFinite,
            child: TabBarView(
              controller: tabController,
              children: [
                ListView.builder(
                    itemCount: projectDataModel.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return OverviewCard(
                        projectName: projectDataModel[index].projectName,index: index,
                      );
                    }),
                const Text("Projects 1"),
            ListView.builder(
                itemCount: completedProjects.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return OverviewCard(
                    projectName: completedProjects[index].projectName,index: index,
                  );
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CircleTab extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    // TODO: implement createBoxPainter
    return CirclePainter();
  }
}

class CirclePainter extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint _paint = Paint();
    _paint.color = Colors.black54;
    final Offset CirclePostion =
        Offset(configuration.size!.width - 3.0, configuration.size!.height / 2);
    canvas.drawCircle(offset + CirclePostion, 4, _paint);
  }
}
