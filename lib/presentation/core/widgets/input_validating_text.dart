import 'package:easy_localization/easy_localization.dart';
import 'package:event_mate/presentation/core/extension/build_context_theme_ext.dart';
import 'package:event_mate/presentation/core/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';

class InputValidatingText extends StatelessWidget {
  const InputValidatingText();

  @override
  Widget build(BuildContext context) {
    final color = context.colors.orangeBase;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomProgressIndicator(color: color, size: 18),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            'registration.input_validating_text'.tr(),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
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
