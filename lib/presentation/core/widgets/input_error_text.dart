import 'package:event_mate/presentation/extension/build_context_theme_ext.dart';
import 'package:flutter/material.dart';

class InputErrorText extends StatelessWidget {
  const InputErrorText({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.error,
          size: 18,
          color: context.colors.error,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: context.colors.error),
          ),
        ),
      ],
    );
  }
}
