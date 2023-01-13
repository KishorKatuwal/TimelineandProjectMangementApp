import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  static const String routeName = '/account-screen';
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return  const Center(
      child: Text("THis is Account Scrreen"),
    );
  }
}
