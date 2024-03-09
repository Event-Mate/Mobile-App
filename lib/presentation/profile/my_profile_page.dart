import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:event_mate/application/authentication_bloc/authentication_bloc.dart';
import 'package:event_mate/application/my_profile_bloc/my_profile_bloc.dart';
import 'package:event_mate/injection.dart';
import 'package:event_mate/presentation/core/constants/app_text_styles.dart';
import 'package:event_mate/presentation/core/extension/build_context_theme_ext.dart';
import 'package:event_mate/presentation/core/extension/build_context_toast_msg_ext.dart';
import 'package:event_mate/presentation/core/widgets/bouncing_button.dart';
import 'package:event_mate/presentation/core/widgets/custom_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MyProfileBloc>()..addFetch(),
      child: Scaffold(
        backgroundColor: context.colors.background,
        body: BlocConsumer<MyProfileBloc, MyProfileState>(
          listener: (context, state) {
            if (state.processFailed) {
              context.showErrorToast(
                'Error occured while loading user profile',
              );
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            if (state.userDataOption.isNone())
              return const Center(child: CircularProgressIndicator());

            final userData = state.userDataOrNull!;

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 300,
                  pinned: true,
                  floating: true,
                  backgroundColor: context.colors.primary,
                  flexibleSpace: FlexibleSpaceBar(
                    background: _ProfilePicture(avatarUrl: userData.avatarUrl),
                    centerTitle: false,
                    titlePadding: const EdgeInsets.only(left: 12, bottom: 12),
                    title: Text(
                      'my_profile_page.page_title'.tr(
                        args: [userData.displayName],
                      ),
                      style: tsHeadLineSmall.copyWith(
                        color: context.colors.whiteBase,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ProfileInformationTile(
                          title:
                              'my_profile_page.display_name_section_title'.tr(),
                          value: userData.displayName,
                        ),
                        _ProfileInformationTile(
                          title: 'my_profile_page.email_section_title'.tr(),
                          value: userData.email,
                        ),
                        _ProfileInformationTile(
                          title: 'my_profile_page.username_section_title'.tr(),
                          value: userData.username,
                        ),
                        _ProfileInformationTile(
                          title: 'my_profile_page.gender_section_title'.tr(),
                          value: userData.genderType.value,
                        ),
                        _ProfileInformationTile(
                          title: 'my_profile_page.birthdate_section_title'.tr(),
                          value: userData.dateOfBirthStr,
                        ),
                        const SizedBox(height: 24),
                        const _LogoutButton()
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ProfileInformationTile extends StatelessWidget {
  const _ProfileInformationTile({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: context.colors.borderPrimary),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: tsBodyMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colors.textPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: tsBodySmall.copyWith(color: context.colors.textPrimary),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfilePicture extends StatelessWidget {
  const _ProfilePicture({required this.avatarUrl});

  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          width: MediaQuery.sizeOf(context).width,
          height: 300 + kToolbarHeight + 2,
          fit: BoxFit.cover,
          imageUrl: avatarUrl,
          placeholder: (context, url) => const CustomPlaceholder(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 300,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                colors: [
                  context.colors.blackBase.withOpacity(0.5),
                  context.colors.blackBase.withOpacity(0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) {
    return BouncingButton(
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 24,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          color: context.colors.background,
          border: Border.all(
            color: context.colors.redBase,
          ),
        ),
        child: Text(
          'my_profile_page.logout_button_title'.tr(),
          textAlign: TextAlign.center,
          style: tsBodyMedium.copyWith(
            color: context.colors.redBase,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onTap: () {
        context.read<AuthenticationBloc>().addLogout();
      },
    );
  }
}
