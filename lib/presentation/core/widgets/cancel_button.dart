import 'package:easy_localization/easy_localization.dart';
import 'package:event_mate/presentation/core/extension/build_context_theme_ext.dart';
import 'package:event_mate/presentation/core/widgets/bouncing_button.dart';
import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BouncingButton(
        onTap: () => Navigator.of(context).pop(),
        child: Text(
          'cancel',
          style: TextStyle(color: context.colors.primary),
        ).tr(),
      ),
    );
  }
}
