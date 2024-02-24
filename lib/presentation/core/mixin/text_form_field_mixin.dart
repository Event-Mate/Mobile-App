import 'package:event_mate/presentation/core/extension/build_context_theme_ext.dart';
import 'package:flutter/material.dart';

//! Currently not used may be deleted later on
mixin TextFormFieldMixin {
  static const _borderWidth = 1.5;

  TextFormField EMTextFormField(
    BuildContext context, {
    TextEditingController? controller,
    Function(String value)? onChanged,
    required String? Function(String? value) validator,
    required String hintText,
  }) {
    assert(onChanged != null || controller != null);
    return TextFormField(
      cursorColor: context.colors.secondary,
      onChanged: onChanged,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: context.colors.surfacePrimary,
        hintText: hintText,
        hintStyle: TextStyle(color: context.colors.textSecondary),
        errorStyle: TextStyle(
          color: context.colors.redBase,
          fontWeight: FontWeight.w600,
        ),
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
            color: context.colors.redBase,
            width: _borderWidth,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: context.colors.redBase,
            width: _borderWidth,
          ),
        ),
      ),
    );
  }
}
