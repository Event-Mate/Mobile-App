import 'package:auto_size_text/auto_size_text.dart';
import 'package:event_mate/model/event_data.dart';
import 'package:event_mate/presentation/core/constants/app_text_styles.dart';
import 'package:event_mate/presentation/core/extension/build_context_easy_navigation_ext.dart';
import 'package:event_mate/presentation/core/extension/build_context_theme_ext.dart';
import 'package:event_mate/presentation/core/widgets/bouncing_button.dart';
import 'package:event_mate/presentation/event_detail/event_detail_page.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  const EventCard({required this.event});
  final EventData event;
  @override
  Widget build(BuildContext context) {
    return BouncingButton(
      onTap: () {
        context.openPage(EventDetailPage(event: event));
      },
      child: Hero(
        tag: event.id,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: context.colors.borderPrimary),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  event.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: const [0.0, 0.25, 0.5, 0.75],
                    colors: [
                      context.colors.blackBase.withOpacity(1.0),
                      context.colors.blackBase.withOpacity(0.75),
                      context.colors.blackBase.withOpacity(0.5),
                      context.colors.blackBase.withOpacity(0.0),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 12,
                left: 8,
                right: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      event.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: tsBodySmall.copyWith(
                        color: context.colors.whiteBase,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 14,
                          color: context.colors.secondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          event.date,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: tsBodySmall.copyWith(
                            color: context.colors.grayBase,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: context.colors.secondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          event.time,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: tsBodySmall.copyWith(
                            color: context.colors.grayBase,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 14,
                          color: context.colors.secondary,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: AutoSizeText(
                            event.location.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: tsBodySmall.copyWith(
                              color: context.colors.grayBase,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
