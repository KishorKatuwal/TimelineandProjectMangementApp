import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timelineandprojectmanagementapp/common/widgets/bottom_bar.dart';
import 'package:timelineandprojectmanagementapp/common/widgets/custom_button.dart';
import 'package:timelineandprojectmanagementapp/common/widgets/custom_textfiels.dart';
import 'package:timelineandprojectmanagementapp/constants/utils.dart';
import 'package:timelineandprojectmanagementapp/features/auth/screens/signup_screen.dart';
import 'package:timelineandprojectmanagementapp/features/auth/services/auth_controller.dart';
import 'package:timelineandprojectmanagementapp/features/auth/services/auth_service.dart';
import 'package:timelineandprojectmanagementapp/features/change_password/widget/password_textfiled.dart';
import 'package:timelineandprojectmanagementapp/model/error_model.dart';

import '../../../model/user.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const String routeName = '/login-screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  bool loader = true;

  //used to show loader when login button is pressed
  Future<void> runMethodForDuration() async {
    setState(() {
      loader = false;
    });
    //used to delay method for 1sec
    await Future.delayed(const Duration(seconds: 1));
    signInUser();
    setState(() {
      loader = true;
    });
  }

   late User user;

  //method for sign in user
  void signInUser() async {
    user = (await ref.read(authControllerProvider).loginTo(
        context: context,
        email: _emailController.text,
        password: _passwordController.text))!;
    if (user.id.isNotEmpty) {
      ref.read(userProvider.notifier).update((state) => user);
      Navigator.pushNamed(context, BottomBar.routeName, arguments: 0);
    } else {
      showSnackBar(context, "in login screen");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 50),
            child: Form(
              key: _signInFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 50),
                    child: Image.asset(
                      'assets/logo.png',
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    'Login with your Account',
                    style: TextStyle(fontSize: 23, color: Colors.black87),
                  ),
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
                      label: "Password",
                      hintText: "Password",
                      obText: true),
                  const SizedBox(
                    height: 25,
                  ),
                  //login button
                  CustomButton(
                    text: "Log in",
                    loader: loader,
                    onTap: () {
                      if (_signInFormKey.currentState!.validate()) {
                        if (_passwordController.text.length < 6) {
                          showSnackBar(context, "Use Longer Password!!");
                        } else {
                          runMethodForDuration();
                        }
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Container(
                  //   margin: const EdgeInsets.only(right: 220, top: 5),
                  //   child: TextButton(
                  //     onPressed: () {},
                  //     child: const Text(
                  //       "Forgot Password?",
                  //       style: TextStyle(color: Colors.redAccent),
                  //     ),
                  //   ),
                  // ),
                  const Divider(
                    color: Colors.black,
                    height: 10,
                    thickness: 2,
                    indent: 5,
                    endIndent: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an Account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, SignupScreen.routeName);
                        },
                        child: const Text(
                          "Sign up now",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
