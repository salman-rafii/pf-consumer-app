// ignore_for_file: use_build_context_synchronously, library_prefixes, avoid_print

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:logger/logger.dart';
import 'package:pf_consumer_app/data/repository/auth_repository.dart';
import 'package:pf_consumer_app/providers/local_storage_provider.dart';
import 'package:pf_consumer_app/providers/toast_provider.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider(this.ref);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> loginUser({
    required BuildContext context,
    required PhoneNumber phoneNumber,
    required String password,
  }) async {
    _setLoading(true);

    try {
      final fullPhone = phoneNumber.phoneNumber ?? '';

      // Access AuthRepository via Riverpod
      final authRepo = ref.read(authRepoProvider);

      final response = await authRepo.login(fullPhone, password);

      if (response.status == true &&
          response.body != null &&
          response.body['token'] != null) {
        final token = response.body['token'] as String;

        // Save token
        await ref.read(localStorageProvider).saveToken(token);

        // Show success toast
        ref.read(snackbarProvider).show("Login successful");

        // Navigate to home screen
        // Navigator.pushReplacementNamed(context, Aoo);
      } else {
        ref.read(snackbarProvider).show(response.body ?? 'Login failed');
      }
    } catch (e) {
      Logger().e("Login Error", error: e);
      ref
          .read(snackbarProvider)
          .show("Something went wrong. Please try again.");
    } finally {
      _setLoading(false);
    }
  }
}
