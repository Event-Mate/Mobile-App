import 'package:easy_localization/easy_localization.dart';
import 'package:event_mate/presentation/extension/build_context_theme_ext.dart';
import 'package:flutter/material.dart';

class InputValidatedText extends StatelessWidget {
  const InputValidatedText();

  @override
  Widget build(BuildContext context) {
    final color = context.colors.primary;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle_outline_rounded, color: color, size: 18),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            'registration.input_validated_text'.tr(),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: color, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
