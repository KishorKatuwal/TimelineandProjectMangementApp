import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timelineandprojectmanagementapp/common/widgets/bottom_bar.dart';
import 'package:timelineandprojectmanagementapp/constants/global_variables.dart';
import 'package:timelineandprojectmanagementapp/features/auth/screens/login_screen.dart';
import 'package:timelineandprojectmanagementapp/features/auth/services/auth_service.dart';
import 'package:timelineandprojectmanagementapp/features/home/screens/home_screen.dart';
import 'package:timelineandprojectmanagementapp/features/schedules/services/schedules_service.dart';
import 'package:timelineandprojectmanagementapp/providers/user_provider.dart';
import 'package:timelineandprojectmanagementapp/router.dart';
import 'features/admin/screens/admin_screen.dart';
import 'features/auth/screens/auth_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final AuthService authService = AuthService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Timeline and Project Management App',
      theme: ThemeData(
          scaffoldBackgroundColor: GlobalVariables.backgroundColour,
          colorScheme:
              const ColorScheme.light(primary: GlobalVariables.mainColor),
          appBarTheme: const AppBarTheme(
              elevation: 0, iconTheme: IconThemeData(color: Colors.black))),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.type == 'user'
              ? const BottomBar(
                  pageIndex: 0,
                )
              : const AdminScreen()
          : const LoginScreen(),
    );
  }
}

//2:30:02
