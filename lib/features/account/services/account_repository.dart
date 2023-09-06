import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:timelineandprojectmanagementapp/features/auth/services/auth_controller.dart';

import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../model/user.dart';

final accountRepositoryProvider = Provider((ref) => AccountRepository());

class AccountRepository {
  void updateUserDetails({
    required BuildContext context,
    required WidgetRef ref,
    required String firstName,
    required String lastName,
    required String group,
    required String faculty,
    required String year,
  }) async {
    final userModel = ref.watch(userProvider);
    try {
      http.Response res = await http.put(
        Uri.parse('$uri/api/update-user-details'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userModel!.token,
        },
        body: jsonEncode({
          'firstName': firstName,
          'lastName': lastName,
          'group': group,
          'faculty': faculty,
          'year': year,
        }),
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, "Successfully edited!!");
            User user = userModel.copyWith(
              group: jsonDecode(res.body)['group'],
              firstName: jsonDecode(res.body)['firstName'],
              lastName: jsonDecode(res.body)['lastName'],
              faculty: jsonDecode(res.body)['faculty'],
              year: jsonDecode(res.body)['year'],
            );
            ref.read(userProvider.notifier).update((state) => user);
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
