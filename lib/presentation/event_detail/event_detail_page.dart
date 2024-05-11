import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_mate/model/event_data.dart';
import 'package:event_mate/presentation/core/constants/app_text_styles.dart';
import 'package:event_mate/presentation/core/extension/build_context_theme_ext.dart';
import 'package:event_mate/presentation/core/widgets/bouncing_button.dart';
import 'package:event_mate/presentation/core/widgets/custom_placeholder.dart';
import 'package:event_mate/presentation/core/widgets/splashing_button.dart';
import 'package:flutter/material.dart';

const double _kContainerChipHeight = 60;

class EventDetailPage extends StatelessWidget {
  const EventDetailPage({required this.event});
  final EventData event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            expandedHeight: MediaQuery.sizeOf(context).height * 0.5,
            backgroundColor: context.colors.background,
            automaticallyImplyLeading: false,
            leading: BouncingButton(
              child: Container(
                margin: const EdgeInsets.only(left: 12, top: 12),
                decoration: BoxDecoration(
                  color: context.colors.blackBase.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: context.colors.whiteBase,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            collapsedHeight: kToolbarHeight,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: event.id,
                child: _EventDetailImage(imageUrl: event.imageUrl),
              ),
              centerTitle: false,
              titlePadding: const EdgeInsets.all(12),
              title: Text(
                event.title,
                style: tsBodyLarge.copyWith(
                  color: context.colors.whiteBase,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _EventInfoChip(
                          title: event.category,
                          iconData: _getIconForCategory(event.category),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _EventInfoChip(
                          title: event.price,
                          iconData: Icons.payments_outlined,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _EventInfoChip(
                          title: event.date,
                          iconData: Icons.calendar_today,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _EventInfoChip(
                          title: event.time,
                          iconData: Icons.access_time,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _EventLocationInfoView(event: event),
                  const SizedBox(height: 12),
                  SplashingButton(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    onTap: () {
                      // TODO(Furkan): Navigate to event attendees page.
                    },
                    decoration: BoxDecoration(
                      color: context.colors.primary,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Text(
                      'Find an event mate',
                      style: tsBodyMedium.copyWith(
                        color: context.colors.background,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EventLocationInfoView extends StatelessWidget {
  const _EventLocationInfoView({required this.event});

  final EventData event;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.colors.surfacePrimary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.colors.borderPrimary,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: context.colors.secondary,
              ),
              const SizedBox(width: 4),
              Text(
                event.place,
                style: tsBodyMedium.copyWith(
                  color: context.colors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          // const SizedBox(height: 8),
          // TODO(Furkan): Add map widget here.
        ],
      ),
    );
  }
}

class _EventInfoChip extends StatelessWidget {
  const _EventInfoChip({required this.iconData, required this.title});

  final IconData iconData;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _kContainerChipHeight,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: context.colors.surfacePrimary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.colors.borderPrimary,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: context.colors.secondary,
          ),
          const SizedBox(width: 4),
          Text(
            title,
            style: tsBodyMedium.copyWith(
              color: context.colors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _EventDetailImage extends StatelessWidget {
  const _EventDetailImage({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => const CustomPlaceholder(),
          errorWidget: (context, url, error) => const CustomPlaceholder(),
        ),
        Container(
          decoration: BoxDecoration(
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
      ],
    );
  }
}

IconData _getIconForCategory(String category) {
  switch (category) {
    case 'Stand Up':
      return Icons.accessibility_new_rounded;
    case 'Concert':
      return Icons.mic_external_on_rounded;
    case 'Sports':
      return Icons.sports_basketball;
    case 'Festival':
      return Icons.festival_outlined;
    case 'Theater':
      return Icons.theater_comedy;
    case 'Conference':
      return Icons.school;
    default:
      return Icons.error;
  }
}
