import 'package:flutter/material.dart';
import 'package:provider/Provider.dart';
import 'package:timelineandprojectmanagementapp/admin/view_users/services/view_user_service.dart';
import 'package:timelineandprojectmanagementapp/constants/utils.dart';
import '../../../model/user.dart';
import '../../../providers/user_provider.dart';

class ViewUserScreen extends StatefulWidget {
  static const String routeName = '/view-user-screen';

  const ViewUserScreen({Key? key}) : super(key: key);

  @override
  State<ViewUserScreen> createState() => _ViewUserScreenState();
}

class _ViewUserScreenState extends State<ViewUserScreen> {
  final ViewUserService viewUserService = ViewUserService();
  List<User> userModel = [];

  void deleteUser(User user, int index) {
    viewUserService.deleteUser(
        context: context,
        userModel: user,
        onSuccess: () {
          //yo index chei tala builder bata aako ho
          userModel.removeAt(index);
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    final userID = Provider.of<UserProvider>(context).user.id;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(15),
        child: FutureBuilder(
          future: viewUserService.fetchAllUsers(context),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("An error occurred: ${snapshot.error}"),
              );
            } else if (!snapshot.hasData || snapshot.data.isEmpty) {
              return const Center(
                child: Text("No users yet!!"),
              );
            } else {
              userModel = snapshot.data;
              return ListView.builder(
                  itemCount: userModel.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 40,
                            color: Colors.blueGrey,
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Text(
                                      "${userModel[index].firstName} ${userModel[index].lastName} (${userModel[index].type})",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      if (userID == userModel[index].id) {
                                        showSnackBar(context, "You cannot delete Yourself!!");
                                      } else {
                                        deleteUser(userModel[index], index);
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.delete_forever_outlined,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              "Total Projects: ${userModel[index].projects.length}",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              "Total Events: ${userModel[index].events.length}",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              "Last Login Date: ${userModel[index].lastActiveTime}",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}
