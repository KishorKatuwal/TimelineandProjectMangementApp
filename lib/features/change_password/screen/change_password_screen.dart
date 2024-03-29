import 'package:flutter/material.dart';
import 'package:timelineandprojectmanagementapp/common/widgets/custom_button.dart';
import 'package:timelineandprojectmanagementapp/constants/utils.dart';
import 'package:timelineandprojectmanagementapp/features/change_password/services/change_password_service.dart';
import 'package:timelineandprojectmanagementapp/features/change_password/widget/password_textfiled.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const String routeName = '/change-password-screen';

  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _changePasswordFormKey = GlobalKey<FormState>();
  final _previousPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _reTypePasswordController = TextEditingController();
  final ChangePasswordService changePasswordService = ChangePasswordService();

  bool _obscureText1 = true;
  bool _obscureText2 = true;
  bool _obscureText3 = true;

  void changePassword() {
    changePasswordService.changePassword(
        context: context,
        previousPassword: _previousPasswordController.text.trim(),
        newPassword: _newPasswordController.text.trim());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _newPasswordController.dispose();
    _previousPasswordController.dispose();
    _reTypePasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Form(
            key: _changePasswordFormKey,
            child: Column(
              children: [
                PasswordTextField(
                    controller: _previousPasswordController,
                    label: "Current Password",
                    hintText: "Current Password",
                    obText: true),
                const SizedBox(
                  height: 15,
                ),
                PasswordTextField(
                    controller: _newPasswordController,
                    label: "New Password",
                    hintText: "New Password",
                    obText: true),
                const SizedBox(
                  height: 15,
                ),
                PasswordTextField(
                    controller: _reTypePasswordController,
                    label: "Re-type New Password",
                    hintText: "Re-type New Password",
                    obText: true),
                const SizedBox(
                  height: 80,
                ),
                CustomButton(
                    text: "Change Password",
                    onTap: () {
                      if (_changePasswordFormKey.currentState!.validate()) {
                        if (_newPasswordController.text.length < 6 ||
                            _reTypePasswordController.text.length < 6) {
                          showSnackBar(
                              context, "Password length is less than 6!");
                        } else {
                          if (_newPasswordController.text ==
                              _reTypePasswordController.text) {
                            changePassword();
                          } else {
                            showSnackBar(context,
                                "New password and Re-typed password didn't matched!!");
                          }
                        }
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
