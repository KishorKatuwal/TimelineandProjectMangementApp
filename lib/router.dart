import 'package:flutter/material.dart';
import 'package:timelineandprojectmanagementapp/common/widgets/bottom_bar.dart';
import 'package:timelineandprojectmanagementapp/features/account/screens/account.dart';
import 'package:timelineandprojectmanagementapp/features/admin/screens/admin_screen.dart';
import 'package:timelineandprojectmanagementapp/features/auth/screens/login_screen.dart';
import 'package:timelineandprojectmanagementapp/features/auth/screens/signup_screen.dart';
import 'features/auth/screens/auth_screen.dart';
import 'features/home/screens/home_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AuthScreen());

    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const HomeScreen());

    case LoginScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const LoginScreen());

    case SignupScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const SignupScreen());

    case AccountScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AccountScreen());

    case BottomBar.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const BottomBar());

      case AdminScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AdminScreen());

    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
                  body: Center(
                child: Text("Screen Doesn't exist"),
              )));
  }
}
