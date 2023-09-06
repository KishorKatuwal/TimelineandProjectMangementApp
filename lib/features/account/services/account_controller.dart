import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timelineandprojectmanagementapp/features/account/services/account_repository.dart';

final accountControllerProvider = Provider((ref) {
  final accountRepository = ref.watch(accountRepositoryProvider);
  return AccountController(accountRepository: accountRepository, ref: ref);
});

class AccountController {
  final AccountRepository accountRepository;
  final ProviderRef ref;

  AccountController({required this.accountRepository, required this.ref});

  void updateUserDetails({
    required BuildContext context,
    required WidgetRef ref,
    required String firstName,
    required String lastName,
    required String group,
    required String faculty,
    required String year,
  }) {
    accountRepository.updateUserDetails(
        context: context,
        ref: ref,
        firstName: firstName,
        lastName: lastName,
        group: group,
        faculty: faculty,
        year: year);
  }
}
