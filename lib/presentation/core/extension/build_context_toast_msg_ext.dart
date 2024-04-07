import 'package:event_mate/presentation/core/extension/build_context_theme_ext.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension BuildContextToastMsgExt on BuildContext {
  void showToast(
    String message, {
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) {
    Fluttertoast.showToast(
      msg: message,
      gravity: gravity,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: colors.surfaceSecondary,
      textColor: colors.textPrimary,
      fontSize: 16.0,
    );
  }

  void showSuccessToast(
    String message, {
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) {
    Fluttertoast.showToast(
      msg: message,
      gravity: gravity,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: colors.greenBase,
      textColor: colors.whiteBase,
      fontSize: 16.0,
    );
  }

  void showErrorToast(
    String message, {
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) {
    Fluttertoast.showToast(
      msg: message,
      gravity: gravity,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: colors.redBase,
      textColor: colors.whiteBase,
      fontSize: 16.0,
    );
  }
}
