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
  final _searchController = TextEditingController();
  List<User> userModel = [];
  List<User> filteredModel = [];
  bool showSearchField = false;
  bool tryD = false;

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

  void hideUser(User user) {
    viewUserService.hideUser(
        context: context, userModel: user, userStatus: true);
  }

  void removeHide(User user) {
    viewUserService.hideUser(
        context: context, userModel: user, userStatus: false);
  }

  void _filterUsers(String query) {
    setState(() {
      userModel = filteredModel
          .where((user) =>
              user.firstName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userID = Provider.of<UserProvider>(context).user.id;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  showSearchField = true;
                });
              },
              icon: const Icon(
                Icons.search,
                size: 35,
                color: Colors.white,
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            showSearchField
                ? Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.cancel_outlined),
                          onPressed: () {
                            setState(() {
                              showSearchField = false;
                              userModel = filteredModel;
                              _searchController.text = "";
                            });
                          },
                        ),
                        hintText: 'Search by first name!!',
                      ),
                      controller: _searchController,
                      onChanged: _filterUsers,
                    ),
                  )
                : Container(),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 100,
              padding: const EdgeInsets.only(
                  right: 15, left: 15, bottom: 30, top: 5),
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
                    filteredModel = snapshot.data;

                    if (!tryD) {
                      userModel = filteredModel;
                      tryD = true;
                    }

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
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Text(
                                            "${userModel[index].firstName} ${userModel[index].lastName} (${userModel[index].type})",
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                        ),
                                        userModel[index].hideUser
                                            ? IconButton(
                                                onPressed: () {
                                                  if (userID ==
                                                      userModel[index].id) {
                                                    showSnackBar(context,
                                                        "You cannot delete Yourself!!");
                                                  } else {
                                                    // deleteUser(userModel[index], index);
                                                    removeHide(
                                                        userModel[index]);
                                                  }
                                                },
                                                icon: const Icon(
                                                  Icons.undo,
                                                  color: Colors.green,
                                                  size: 30,
                                                ),
                                              )
                                            : IconButton(
                                                onPressed: () {
                                                  if (userID ==
                                                      userModel[index].id) {
                                                    showSnackBar(context,
                                                        "You cannot delete Yourself!!");
                                                  } else {
                                                    // deleteUser(userModel[index], index);
                                                    hideUser(userModel[index]);
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
                                    "User Status: ${userModel[index].hideUser ? "Removed" : "Active User"}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: userModel[index].hideUser
                                          ? Colors.red
                                          : Colors.black54,
                                    ),
                                  ),
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
          ],
        ),
      ),
    );
  }
}
