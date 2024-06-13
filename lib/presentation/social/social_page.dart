import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_mate/application/social_posts_bloc/social_posts_bloc.dart';
import 'package:event_mate/injection.dart';
import 'package:event_mate/model/event_data.dart';
import 'package:event_mate/model/post_data.dart';
import 'package:event_mate/model/user_data.dart';
import 'package:event_mate/presentation/core/constants/app_text_styles.dart';
import 'package:event_mate/presentation/core/extension/build_context_theme_ext.dart';
import 'package:event_mate/presentation/core/widgets/bouncing_button.dart';
import 'package:event_mate/presentation/core/widgets/custom_placeholder.dart';
import 'package:event_mate/presentation/core/widgets/custom_progress_indicator.dart';
import 'package:event_mate/presentation/home/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialPage extends StatelessWidget {
  const SocialPage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SocialPostsBloc>()..addFetchAllPosts(),
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: BlocBuilder<SocialPostsBloc, SocialPostsState>(
          buildWhen: (previous, current) {
            return previous.failureOrPostListOption !=
                current.failureOrPostListOption;
          },
          builder: (context, state) {
            if (state.failureOrPostListOption.isNone()) {
              return const Center(child: CustomProgressIndicator());
            }

            if (state.postListOrEmpty.isEmpty()) {
              return Center(
                child: Text(
                  'No posts found 😥',
                  style: tsHeadLineSmall.copyWith(
                    color: context.colors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }

            return ListView.builder(
              // TODO(Furkan): post list implementation
              itemCount: state.postListOrEmpty.size,
              itemBuilder: (context, index) {
                return _PostItem(postData: state.postListOrEmpty[index]);
              },
            );
          },
        ),
      ),
    );
  }
}

class _PostItem extends StatelessWidget {
  const _PostItem({required this.postData});
  final PostData postData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: context.colors.borderPrimary),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PostCreatorInfo(userData: postData.userData),
          const SizedBox(height: 8),
          _EventInfo(event: postData.eventData),
          const SizedBox(height: 8),
          _PostContentInfo(text: postData.content),
          const SizedBox(height: 8),
          _EventAttendanceInfo(event: postData.eventData),
        ],
      ),
    );
  }
}

class _EventInfo extends StatelessWidget {
  const _EventInfo({required this.event});
  final EventData event;
  @override
  Widget build(BuildContext context) {
    // TODO(Furkan): maxlines 5 oldugu icin tamamaı okunmayabilir bu yüzden detail sayfası yapmamız gerekebilir.
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = width * 0.5;
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
                height: height,
                placeholder: (context, url) => const CustomPlaceholder(),
                imageUrl: event.imageUrl,
              ),
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      context.colors.blackBase.withOpacity(0),
                      context.colors.blackBase.withOpacity(1),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                left: 8,
                right: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      event.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: tsBodyMedium.copyWith(
                        color: context.colors.whiteBase,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _EventInfoItem(
                      icon: Icons.calendar_today,
                      text: event.date,
                    ),
                    _EventInfoItem(
                      icon: Icons.access_time,
                      text: event.time,
                    ),
                    _EventInfoItem(
                      icon: Icons.location_on,
                      text: event.location.name,
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
  const _EventAttendanceInfo({required this.event});
  final EventData event;
  @override
  Widget build(BuildContext context) {
    final attendingCount = event.attendantIds.size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (attendingCount > 0)
          Text(
            // TODO(Furkan): translate
            '$attendingCount people are attending',
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
          Icon(icon, size: 18, color: context.colors.secondary),
          const SizedBox(width: 4),
          Text(
            text,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: tsBodySmall.copyWith(
              color: context.colors.grayBase,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _PostContentInfo extends StatelessWidget {
  const _PostContentInfo({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: tsBodyMedium.copyWith(color: context.colors.textPrimary),
      maxLines: 5,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _PostCreatorInfo extends StatelessWidget {
  const _PostCreatorInfo({required this.userData});
  final UserData userData;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _CircleAvatar(imageUrl: userData.avatarUrl),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userData.displayName,
              style: tsBodySmall.copyWith(
                color: context.colors.textPrimary,
              ),
            ),
            Text(
              '@${userData.username}',
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
