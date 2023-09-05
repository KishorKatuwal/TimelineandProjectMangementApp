import 'package:flutter/material.dart';
import 'package:timelineandprojectmanagementapp/common/widgets/custom_button.dart';
import 'package:timelineandprojectmanagementapp/common/widgets/custom_textfiels.dart';
import 'package:timelineandprojectmanagementapp/features/auth/services/auth_service.dart';
import 'package:timelineandprojectmanagementapp/features/change_password/widget/password_textfiled.dart';

import '../../../constants/utils.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = '/signup-screen';

  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final AuthService authService = AuthService();
  final _signUpFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _groupController = TextEditingController();
  //giving initial value to dropdown
  String category = 'Year1';
  String facultyValue = "Computing";

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _groupController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
  }

  //calling method to sign up user
  void signUpUser() {
    authService.signUpUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      faculty: facultyValue,
      group: _groupController.text.toUpperCase(),
      year: category,
    );
  }

  //values for year categories
  List<String> yearCategories = [
    'Year1',
    'Year2',
    'Year3',
  ];

  //values for year categories
  List<String> facultyCategories = [
    'Computing',
    'Multimedia',
    'Networking',
  ];

  bool loader = true;
//calling method to show loader
  Future<void> runMethodForDuration() async {
    setState(() {
      loader = false;
    });
    await Future.delayed(const Duration(seconds: 1));
    signUpUser();
    setState(() {
      loader = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create a New Account"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Form(
              key: _signUpFormKey,
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
                      controller: _emailController, hintText: "Email"),
                  const SizedBox(
                    height: 15,
                  ),
                  PasswordTextField(
                    controller: _passwordController,
                    hintText: "Password",
                    obText: true,
                    label: "Password",
                  ),
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
                    height: 25,
                  ),
                  //Sign Up button
                  CustomButton(
                    text: "Sign Up",
                    loader: loader,
                    onTap: () {
                      if (_signUpFormKey.currentState!.validate()) {
                        if(_passwordController.text.length<6){
                          showSnackBar(context, "Use Longer Password!!");
                        }else{
                          runMethodForDuration();
                        }
                      }
                    },
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
