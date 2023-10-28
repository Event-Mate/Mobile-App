import 'package:event_mate/presentation/extension/build_context_theme_ext.dart';
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
      backgroundColor: colors.borderSecondary,
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
      backgroundColor: colors.success,
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
      backgroundColor: colors.error,
      textColor: colors.whiteBase,
      fontSize: 16.0,
    );
  }
}
