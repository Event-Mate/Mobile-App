import 'package:event_mate/presentation/extension/build_context_theme_ext.dart';
import 'package:flutter/material.dart';

mixin TextFormFieldStyleMixin {
  static const _borderWidth = 1.5;
  InputDecoration getInputDecoration(
    BuildContext context, {
    required String hintText,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: context.colors.surfacePrimary,
      hintText: hintText,
      hintStyle: TextStyle(color: context.colors.textSecondary),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(
          color: context.colors.borderPrimary,
          width: _borderWidth,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(
          color: context.colors.primary,
          width: _borderWidth,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: context.colors.error,
          width: _borderWidth,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: context.colors.error,
          width: _borderWidth,
        ),
      ),
    );
  }
}
