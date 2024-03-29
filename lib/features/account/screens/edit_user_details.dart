import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timelineandprojectmanagementapp/constants/utils.dart';
import 'package:timelineandprojectmanagementapp/features/account/services/account_controller.dart';
import 'package:timelineandprojectmanagementapp/features/account/services/account_service.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_textfiels.dart';

class EditUserDetails extends ConsumerStatefulWidget {
  final String firstName;
  final String lastName;
  final String group;
  final String year;
  final String faculty;

  const EditUserDetails(
      {Key? key,
      required this.firstName,
      required this.lastName,
      required this.group,
      required this.year,
      required this.faculty})
      : super(key: key);

  @override
  ConsumerState<EditUserDetails> createState() => _EditUserDetailsState();
}

class _EditUserDetailsState extends ConsumerState<EditUserDetails> {
  final _editFormKey = GlobalKey<FormState>();
  final AccountService accountService = AccountService();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _groupController = TextEditingController();
  late String category;
  late String facultyValue;
  bool buttonLoader = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    category = widget.year;
    facultyValue = widget.faculty;
    _firstNameController.text = widget.firstName;
    _lastNameController.text = widget.lastName;
    _groupController.text = widget.group;
  }

  @override
  void dispose() {
    super.dispose();
    _groupController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
  }

//method for updating user details
  void updateUserDetails() {
    ref.read(accountControllerProvider).updateUserDetails(
        context: context,
        ref: ref,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        group: _groupController.text,
        faculty: facultyValue,
        year: category);
  }

  List<String> yearCategories = [
    'Year1',
    'Year2',
    'Year3',
  ];

  List<String> facultyCategories = [
    'Computing',
    'Multimedia',
    'Networking',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit User Details"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Form(
              key: _editFormKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 35,
                  ),
                  CustomTextField(
                      controller: _firstNameController, hintText: "First Name"),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                      controller: _lastNameController, hintText: "Last Name"),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                      controller: _groupController, hintText: "Group"),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                          right: 10,
                          left: 10,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Colors.black38,
                                width: 1,
                                style: BorderStyle.solid)),
                        child: DropdownButton(
                          value: category,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: yearCategories.map((String item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (String? newVal) {
                            setState(() {
                              category = newVal!;
                            });
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          right: 10,
                          left: 10,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Colors.black38,
                                width: 1,
                                style: BorderStyle.solid)),
                        child: DropdownButton(
                          elevation: 0,
                          value: facultyValue,
                          borderRadius: BorderRadius.circular(10),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: facultyCategories.map((String item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (String? newVal) {
                            setState(() {
                              facultyValue = newVal!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomButton(
                    text: "Edit Details",
                    onTap: () {
                      if (_editFormKey.currentState!.validate()) {
                        //checking if same details are provided or not
                        if (_firstNameController.text == widget.firstName &&
                            _lastNameController.text == widget.lastName &&
                            _groupController.text == widget.group &&
                            facultyValue == widget.faculty &&
                            category == widget.year) {
                          showSnackBar(context, "Same details Provided!!");
                        } else {
                          updateUserDetails();
                          _firstNameController.clear();
                          _lastNameController.clear();
                          _groupController.clear();
                          setState(() {
                            buttonLoader = false;
                          });
                        }
                      }
                    },
                    loader: buttonLoader,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
