import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_mate/presentation/core/constants/app_text_styles.dart';
import 'package:event_mate/presentation/core/extension/build_context_theme_ext.dart';
import 'package:event_mate/presentation/core/widgets/bouncing_button.dart';
import 'package:event_mate/presentation/core/widgets/custom_placeholder.dart';
import 'package:event_mate/presentation/home/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class SocialPage extends StatelessWidget {
  const SocialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.builder(
          // TODO(Furkan): post list implementation
          itemCount: 20,
          itemBuilder: (context, index) {
            return const _PostItem();
          },
        ),
      ),
    );
  }
}

class _PostItem extends StatelessWidget {
  const _PostItem();
  // TODO(Furkan): post data will be received as parameter
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const _PostCreatorInfo(),
          const SizedBox(height: 4),
          // TODO(Furkan): maxlines 5 oldugu icin tamamaı okunmayabilir bu yüzden detail sayfası yapmamız gerekebilir.
          const _EventInfoCard(),
          const SizedBox(height: 4),
          const _PostText(),
          const SizedBox(height: 4),
          const _EventAttendanceInfo(),
        ],
      ),
    );
  }
}

class _EventInfoCard extends StatelessWidget {
  const _EventInfoCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              CachedNetworkImage(
                errorWidget: (context, url, err) => const CustomPlaceholder(),
                fadeOutDuration: const Duration(milliseconds: 100),
                fadeInDuration: const Duration(milliseconds: 100),
                placeholderFadeInDuration: const Duration(
                  milliseconds: 100,
                ),
                fit: BoxFit.cover,
                width: width,
                height: width * 0.6,
                placeholder: (context, url) => const CustomPlaceholder(),
                // TODO(Furkan): img
                imageUrl: 'https://picsum.photos/200/300',
              ),
              Container(
                width: width,
                height: width * 0.6,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      context.colors.blackBase.withOpacity(0),
                      context.colors.blackBase.withOpacity(.5),
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
                      // TODO(Furkan): eventittle will be received as parameter
                      'event.title',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: tsBodyLarge.copyWith(
                        color: context.colors.whiteBase,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const _EventInfoItem(
                      icon: Icons.calendar_today,
                      // TODO(Furkan): event.date
                      text: 'event.date',
                    ),
                    const _EventInfoItem(
                      icon: Icons.access_time,
                      // TODO(Furkan): event.time
                      text: 'event.time',
                    ),
                    const _EventInfoItem(
                      icon: Icons.location_on,
                      // TODO(Furkan): event.location
                      text: 'event.location',
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _EventAttendanceInfo extends StatelessWidget {
  const _EventAttendanceInfo();

  @override
  Widget build(BuildContext context) {
    // TODO(Furkan): update
    final attendantCount = 12;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (attendantCount > 0)
          Text(
            // TODO(Furkan): translate
            '12 people are attending',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: tsBodySmall.copyWith(color: context.colors.secondary),
          )
        else
          const SizedBox(),
        const _AttendEventButton(),
      ],
    );
  }
}

class _AttendEventButton extends StatelessWidget {
  const _AttendEventButton();

  @override
  Widget build(BuildContext context) {
    return BouncingButton(
      onTap: () {
        // TODO(Furkan): Attend button implementation
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: context.colors.background,
          border: Border.all(color: context.colors.secondary),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              // TODO(Furkan): Change the icon when success
              Icons.run_circle_outlined,
              // Icons.check_circle,
              color: context.colors.secondary,
              size: 20,
            ),
            const SizedBox(width: 4),
            Text(
              // TODO(Furkan): translate
              'Attend',
              style: tsBodySmall.copyWith(
                color: context.colors.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EventInfoItem extends StatelessWidget {
  const _EventInfoItem({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: context.colors.secondary),
          const SizedBox(width: 4),
          Text(
            // TODO(Furkan): event.date will be received as parameter
            text,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: tsBodyMedium.copyWith(
              color: context.colors.grayBase,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _PostText extends StatelessWidget {
  const _PostText();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nec odio vitae libero.' *
          (Random().nextInt(5) + 1),
      style: tsBodyMedium.copyWith(color: context.colors.textPrimary),
      maxLines: 5,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _PostCreatorInfo extends StatelessWidget {
  const _PostCreatorInfo();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const _CircleAvatar(
          // TODO(Furkan): Change the imageUrl
          imageUrl: 'https://randomuser.me/api/portraits/men/23.jpg',
        ),
        const SizedBox(width: 8),
        Column(
          children: [
            Text(
              'John Doe',
              style: tsBodySmall.copyWith(
                color: context.colors.textPrimary,
              ),
            ),
            Text(
              '@johndoe',
              style: tsBodySmall.copyWith(
                color: context.colors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _CircleAvatar extends StatelessWidget {
  const _CircleAvatar({required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: CachedNetworkImage(
        errorWidget: (context, url, err) => const CustomPlaceholder(),
        fadeOutDuration: const Duration(milliseconds: 100),
        fadeInDuration: const Duration(milliseconds: 100),
        placeholderFadeInDuration: const Duration(
          milliseconds: 100,
        ),
        fit: BoxFit.cover,
        height: 36,
        width: 36,
        placeholder: (context, url) => const CustomPlaceholder(),
        imageUrl: imageUrl,
      ),
    );
  }
}
