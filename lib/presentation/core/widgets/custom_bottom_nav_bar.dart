import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_mate/application/bottom_navbar_bloc/bottom_navbar_bloc.dart';
import 'package:event_mate/presentation/core/constants/app_text_styles.dart';
import 'package:event_mate/presentation/core/extension/build_context_theme_ext.dart';
import 'package:event_mate/presentation/core/widgets/custom_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_nav_bar/google_nav_bar.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar();

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: BlocBuilder<BottomNavbarBloc, BottomNavbarState>(
        // TODO(Furkan): bwhen
        builder: (context, state) {
          final selectedIndex = state.selectedIndex;
          return GNav(
            gap: 8,
            padding: const EdgeInsets.all(8),
            tabMargin: const EdgeInsets.only(top: 12),
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            backgroundColor: context.colors.background,
            curve: Curves.easeIn,
            tabActiveBorder:
                Border.all(color: context.colors.primary, width: 0.8),
            tabBackgroundColor: context.colors.primary.withOpacity(.15),
            rippleColor: context.colors.primary.withOpacity(.15),
            activeColor: context.colors.textPrimary,
            color: context.colors.textPrimary,
            textStyle: tsBodySmall.copyWith(color: context.colors.textPrimary),
            selectedIndex: selectedIndex,
            onTabChange: (index) {
              context.read<BottomNavbarBloc>().addUpdateIndex(index);
            },
            tabs: [
              // #translate: buton textleri
              const GButton(
                icon: Icons.home_rounded,
                text: 'Anasayfa',
              ),
              const GButton(
                icon: Icons.list,
                text: 'Etkinlikler',
              ),
              const GButton(
                icon: Icons.people,
                text: 'Arkadaş Bul',
              ),
              GButton(
                //! This icon is not used, but it is required by the package
                icon: Icons.hourglass_empty,
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CachedNetworkImage(
                    errorWidget: (context, url, err) {
                      return const CustomPlaceholder();
                    },
                    fadeOutDuration: const Duration(milliseconds: 100),
                    fadeInDuration: const Duration(milliseconds: 100),
                    placeholderFadeInDuration: const Duration(
                      milliseconds: 100,
                    ),
                    fit: BoxFit.cover,
                    height: 24,
                    width: 24,
                    placeholder: (context, url) => const CustomPlaceholder(),
                    // TODO(Furkan): replace with profile avatar url
                    imageUrl: '',
                  ),
                ),
                text: 'Profil',
              ),
            ],
          );
        },
      ),
    );
  }
}
