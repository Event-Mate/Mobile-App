import 'package:easy_localization/easy_localization.dart';
import 'package:event_mate/presentation/core/constants/app_text_styles.dart';
import 'package:event_mate/presentation/core/extension/build_context_theme_ext.dart';
import 'package:flutter/material.dart';

// TODO(Furkan): use it
class InputValidatedText extends StatelessWidget {
  const InputValidatedText();

  @override
  Widget build(BuildContext context) {
    final color = context.colors.primary;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle_outline_rounded, color: color, size: 20),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            'registration.input_validated_text'.tr(),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: tsBodySmall.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
