import 'package:event_mate/application/authentication_bloc/authentication_bloc.dart';
import 'package:event_mate/application/bottom_navbar_bloc/bottom_navbar_bloc.dart';
import 'package:event_mate/application/event_fetcher_bloc/event_fetcher_bloc.dart';
import 'package:event_mate/injection.dart';
import 'package:event_mate/presentation/core/extension/build_context_theme_ext.dart';
import 'package:event_mate/presentation/core/widgets/custom_bottom_nav_bar.dart';
import 'package:event_mate/presentation/home/home_page.dart';
import 'package:event_mate/presentation/profile/my_profile_page.dart';
import 'package:event_mate/presentation/social/social_page.dart';
import 'package:event_mate/presentation/suggested_events/suggested_events_page.dart';
import 'package:event_mate/restartable_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage();

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final PageController _pageController;
  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<EventFetcherBloc>()
            ..addFetchCategories()
            ..addFetchAllEvents(),
        ),
      ],
      child: Scaffold(
        backgroundColor: context.colors.background,
        bottomNavigationBar: const CustomBottomNavBar(),
        body: MultiBlocListener(
          listeners: [
            BlocListener<BottomNavbarBloc, BottomNavbarState>(
              listenWhen: (previous, current) =>
                  previous.selectedIndex != current.selectedIndex,
              listener: (context, state) {
                if (mounted) {
                  _pageController.jumpToPage(state.selectedIndex);
                }
              },
            ),
            BlocListener<AuthenticationBloc, AuthenticationState>(
              listenWhen: (previous, current) =>
                  previous is AuthLoggedInState &&
                  current is AuthLoggedOutState,
              listener: (context, state) {
                RestartableApp.restartApp(context);
              },
            ),
          ],
          child: PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            restorationId: 'main_page_view',
            controller: _pageController,
            itemCount: _pages.length,
            itemBuilder: (context, index) => _pages[index],
          ),
        ),
      ),
    );
  }

  static const Map<int, Widget> _pages = {
    BottomNavbarHomePageState.index: HomePage(),
    BottomNavbarEventsPageState.index: SuggestedEventsPage(),
    BottomNavbarSocialPageState.index: SocialPage(),
    BottomNavbarProfilePageState.index: MyProfilePage(),
  };
}
