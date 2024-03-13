import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:event_mate/application/event_fetcher_bloc/event_fetcher_bloc.dart';
import 'package:event_mate/model/event_data.dart';
import 'package:event_mate/presentation/core/constants/app_text_styles.dart';
import 'package:event_mate/presentation/core/extension/build_context_theme_ext.dart';
import 'package:event_mate/presentation/core/widgets/bouncing_button.dart';
import 'package:event_mate/presentation/core/widgets/custom_progress_indicator.dart';
import 'package:event_mate/presentation/home/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: const CustomAppBar(),
      body: BlocBuilder<EventFetcherBloc, EventFetcherState>(
        builder: (context, state) {
          if (state.fetchingCategories || state.fetchingEvents) {
            return const Center(child: CustomProgressIndicator());
          }
          return RefreshIndicator(
            color: context.colors.primary,
            backgroundColor: context.colors.background,
            onRefresh: () async {
              // TODO(Furkan): Implement refresh logic
              await Future.delayed(const Duration(seconds: 5));
            },
            child: const SingleChildScrollView(
              child: Column(
                children: [
                  _CategoriesSection(),
                  _AllEventsSection(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _AllEventsSection extends StatelessWidget {
  const _AllEventsSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventFetcherBloc, EventFetcherState>(
      buildWhen: (previous, current) =>
          previous.eventsOrEmptyList != current.eventsOrEmptyList,
      builder: (context, state) {
        final events = state.eventsOrEmptyList;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'home_page.all_events_section_title'.tr(),
                style: tsBodyMedium.copyWith(
                  color: context.colors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 2 / 3,
              ),
              itemCount: events.size,
              itemBuilder: (context, index) {
                return _EventCard(event: events[index]);
              },
            ),
          ],
        );
      },
    );
  }
}

class _EventCard extends StatelessWidget {
  const _EventCard({required this.event});
  final EventData event;
  @override
  Widget build(BuildContext context) {
    return Container(
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
                      size: 16,
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
                      size: 16,
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
                      size: 16,
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
    );
  }
}

class _CategoriesSection extends StatelessWidget {
  const _CategoriesSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventFetcherBloc, EventFetcherState>(
      buildWhen: (previous, current) =>
          previous.categoriesOrEmptyList != current.categoriesOrEmptyList,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                'home_page.categories_title'.tr(),
                style: tsBodyMedium.copyWith(
                  color: context.colors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const _EventCategoryChips(),
          ],
        );
      },
    );
  }
}

class _EventCategoryChips extends StatelessWidget {
  const _EventCategoryChips();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventFetcherBloc, EventFetcherState>(
      buildWhen: (previous, current) =>
          previous.categoriesOrEmptyList != current.categoriesOrEmptyList,
      builder: (context, state) {
        final categories = state.categoriesOrEmptyList;

        if (categories.isEmpty()) return const SizedBox();

        return SizedBox(
          height: 100,
          child: categories.size > 4
              ? ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.size,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        right: index != categories.size - 1 ? 8.0 : 0.0,
                      ),
                      child: _EventChip(
                        title: categories[index],
                        icon: state.getIconForCategory(categories[index]),
                      ),
                    );
                  },
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      for (var i = 0; i < categories.size; i++) ...[
                        Expanded(
                          child: _EventChip(
                            title: categories[i],
                            icon: state.getIconForCategory(categories[i]),
                          ),
                        ),
                        if (i != categories.size - 1) const SizedBox(width: 8),
                      ]
                    ],
                  ),
                ),
        );
      },
    );
  }
}

class _EventChip extends StatelessWidget {
  const _EventChip({required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return BouncingButton(
      onTap: () {
        // TODO(Furkan): Navigate to events page with category filter.
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 4,
        decoration: BoxDecoration(
          color: context.colors.surfacePrimary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: context.colors.borderPrimary,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 30,
              color: context.colors.secondary,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: tsBodySmall.copyWith(
                color: context.colors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
