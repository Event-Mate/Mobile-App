import 'package:event_mate/presentation/core/constants/app_text_styles.dart';
import 'package:event_mate/presentation/core/extension/build_context_theme_ext.dart';
import 'package:event_mate/presentation/core/widgets/input_error_text.dart';
import 'package:event_mate/presentation/core/widgets/input_validating_text.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.controller,
    this.onChanged,
    this.errorText,
    this.validating,
    this.leading,
    this.trailing,
    this.value,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  }) : assert(
          controller == null || onChanged == null,
          'Cannot provide both a controller and an onChanged callback at the same time!',
        );

  final TextEditingController? controller;
  final Function(String value)? onChanged;
  final String? hintText;
  final String? errorText;
  final bool? validating;
  final Widget? leading;
  final Widget? trailing;
  final String? value;
  final TextInputType keyboardType;
  final bool obscureText;

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = widget.errorText != null
        ? context.colors.redBase
        : _focusNode.hasFocus
            ? context.colors.primary
            : context.colors.borderPrimary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: context.colors.surfacePrimary,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              if (widget.leading != null) widget.leading!,
              Expanded(
                child: TextFormField(
                  initialValue: widget.value,
                  onChanged: widget.onChanged,
                  controller: widget.controller,
                  keyboardType: widget.keyboardType,
                  obscureText: widget.obscureText,
                  cursorColor: widget.errorText != null
                      ? context.colors.redBase
                      : context.colors.primary,
                  style: tsBodyMedium.copyWith(
                    color: context.colors.textPrimary,
                  ),
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: tsBodyMedium.copyWith(
                      color: context.colors.textSecondary,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              if (widget.trailing != null) widget.trailing!,
            ],
          ),
        ),
        if (widget.validating != null && widget.validating!) ...{
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: InputValidatingText(),
          )
        } else if (widget.errorText != null) ...{
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: InputErrorText(text: widget.errorText!),
          )
        }
      ],
    );
  }
}
