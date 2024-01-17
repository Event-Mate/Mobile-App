import 'package:event_mate/application/my_profile_bloc/my_profile_bloc.dart';
import 'package:event_mate/presentation/core/constants/app_text_styles.dart';
import 'package:event_mate/presentation/core/extension/build_context_theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;
    final avatarUrl = context.read<MyProfileBloc>().state.avatarUrlOrEmpty;
    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: GNav(
        gap: 8,
        padding: const EdgeInsets.all(8),
        tabMargin: const EdgeInsets.only(top: 12),
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        backgroundColor: context.colors.background,
        curve: Curves.easeIn,
        tabActiveBorder: Border.all(color: context.colors.primary, width: 0.8),
        tabBackgroundColor: context.colors.primary.withOpacity(.15),
        rippleColor: context.colors.primary.withOpacity(.15),
        activeColor: context.colors.textPrimary,
        color: context.colors.textPrimary,
        textStyle: tsBodySmall.copyWith(color: context.colors.textPrimary),
        tabs: [
          GButton(
            icon: Icons.home_rounded,
            text: 'Anasayfa',
            onPressed: () {},
          ),
          GButton(
            icon: Icons.list,
            text: 'Etkinlikler',
            onPressed: () {},
          ),
          GButton(
            icon: Icons.people,
            text: 'Arkadaş Bul',
            onPressed: () {},
          ),
          GButton(
            //! This icon is not used, but it is required by the package
            icon: Icons.hourglass_empty,
            leading: CircleAvatar(
              radius: 12,
              backgroundImage: NetworkImage(avatarUrl),
            ),
            text: 'Profil',
          ),
        ],
      ),
    );
  }
}
