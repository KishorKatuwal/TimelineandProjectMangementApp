import 'package:flutter/material.dart';
import 'package:timelineandprojectmanagementapp/admin/admin_feedback/screens/view_feedback_screen.dart';
import 'package:timelineandprojectmanagementapp/admin/view_users/screens/view_user_screen.dart';
import 'package:timelineandprojectmanagementapp/common/widgets/bottom_bar.dart';
import 'package:timelineandprojectmanagementapp/features/account/screens/account.dart';
import 'package:timelineandprojectmanagementapp/features/auth/screens/login_screen.dart';
import 'package:timelineandprojectmanagementapp/features/auth/screens/signup_screen.dart';
import 'package:timelineandprojectmanagementapp/features/discussion/chat_screens/group_screen.dart';
import 'package:timelineandprojectmanagementapp/features/discussion/screens/discussion_screen.dart';
import 'package:timelineandprojectmanagementapp/features/event/screens/add_event_screen.dart';
import 'package:timelineandprojectmanagementapp/features/event/screens/event_screen.dart';
import 'package:timelineandprojectmanagementapp/features/exam/screen/exam_screen.dart';
import 'package:timelineandprojectmanagementapp/features/feedback/screens/feedback_screen.dart';
import 'package:timelineandprojectmanagementapp/features/event/screens/view_addedEvent_screen.dart';
import 'package:timelineandprojectmanagementapp/features/feedback/screens/user_feedback_screen.dart';
import 'package:timelineandprojectmanagementapp/settings/settings.dart';
import 'admin/main_screen/admin_screen.dart';

import 'features/change_password/screen/change_password_screen.dart';


Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {



    case LoginScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const LoginScreen());

    case SignupScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const SignupScreen());

    case AccountScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AccountScreen());

    case DiscussionScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const DiscussionScreen());

    case GroupScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const GroupScreen());

    case BottomBar.routeName:
      var pageIndex = routeSettings.arguments as int;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => BottomBar(pageIndex: pageIndex));

    case AddEventScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AddEventScreen());

    case EventScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const EventScreen());

    // case ViewEventScreen.routeName:
    //   return MaterialPageRoute(
    //       settings: routeSettings, builder: (_) => const ViewEventScreen());

    case FeedbackScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const FeedbackScreen());

    case SettingsScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const SettingsScreen());

    case ViewAddedEventScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const ViewAddedEventScreen());

    case ChangePasswordScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const ChangePasswordScreen());

    case ExamScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const ExamScreen());

    //for admin
    case AdminScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AdminScreen());

    case ViewFeedbackScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const ViewFeedbackScreen());


    case UserFeedbackScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const UserFeedbackScreen());

    case ViewUserScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const ViewUserScreen());

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("Screen Doesn't exist"),
          ),
        ),
      );
  }
}
