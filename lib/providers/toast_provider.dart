// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pf_consumer_app/theme/app_theme.dart';
import 'package:pf_consumer_app/utils/dimensions.dart';
import 'package:pf_consumer_app/views/widgets/app_text.dart';

enum SnackbarType { error, info, success }

final snackbarProvider = Provider<SnackBarService>((ref) {
  return SnackBarService();
});

class SnackBarService {
  GlobalKey<ScaffoldMessengerState> key = GlobalKey<ScaffoldMessengerState>();
  // function to show snackbar
  show(
    String message, {
    SnackbarType type = SnackbarType.info,
    void Function(String)? callback,
  }) {
    key.currentState?.showSnackBar(
      SnackBar(
        content: AppText(
          text: message,
          style: TextStyle(fontSize: Dimensions.fontSizeSmall),
        ),
        shape: const StadiumBorder(),
        margin: const EdgeInsets.all(10),
        behavior: SnackBarBehavior.floating,
        backgroundColor: type == SnackbarType.error
            ? AppTheme.red
            : type == SnackbarType.success
            ? AppTheme.green
            : null,
      ),
    );
  }
}
