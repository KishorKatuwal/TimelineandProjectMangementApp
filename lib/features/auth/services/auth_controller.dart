import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/error_model.dart';
import '../../../model/user.dart';
import 'auth_repository.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository, ref: ref);
});

final userProvider = StateProvider<User?>((ref) => null);

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;

  AuthController({required this.authRepository, required this.ref});

  void signUp({
    required BuildContext context,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String group,
    required String year,
    required String faculty,
  }) {
    authRepository.signUpUser(
        context: context,
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        group: group,
        faculty: faculty,
        year: year);
  }

  Future<User> loginTo(
      {required BuildContext context,
      required String email,
      required String password}) async {
    return await authRepository.signInUser(
        context: context, email: email, password: password);
  }

  Future<ErrorModel> getUserData({
    required BuildContext context,
  }) async {
    return await authRepository.getUserData(context);
  }
}
