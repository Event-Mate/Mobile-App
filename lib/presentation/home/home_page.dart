import 'package:easy_localization/easy_localization.dart';
import 'package:event_mate/application/event_fetcher_bloc/event_fetcher_bloc.dart';
import 'package:event_mate/application/my_profile_bloc/my_profile_bloc.dart';
import 'package:event_mate/injection.dart';
import 'package:event_mate/presentation/core/constants/app_text_styles.dart';
import 'package:event_mate/presentation/core/extension/build_context_theme_ext.dart';
import 'package:event_mate/presentation/core/widgets/bouncing_button.dart';
import 'package:event_mate/presentation/home/widgets/home_page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<MyProfileBloc>()..addFetch()),
        BlocProvider(create: (_) => getIt<EventFetcherBloc>()..addFetch()),
      ],
      child: Scaffold(
        backgroundColor: context.colors.background,
        appBar: const HomePageAppBar(),
        body: const Column(
          children: [
            _CategoriesSection(),
          ],
        ),
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
          previous.categoriesOrEmpty != current.categoriesOrEmpty,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'home_page.categories_title'.tr(),
                style: tsBodyLarge.copyWith(
                  color: context.colors.textPrimary,
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
          previous.categoriesOrEmpty != current.categoriesOrEmpty,
      builder: (context, state) {
        final categories = state.categoriesOrEmpty;

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
