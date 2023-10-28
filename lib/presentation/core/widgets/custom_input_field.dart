import 'package:event_mate/presentation/extension/build_context_theme_ext.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    super.key,
    required this.hintText,
    required this.label,
    required this.controller,
  });

  final String hintText;
  final Text label;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: context.colors.primary,
      decoration: InputDecoration(
        hintText: hintText,
        label: label,
      ),
    );
  }
}
