part of 'package:event_mate/event_mate_app.dart';

/// [RootPage] is an onboarding page
/// that checks if the user is logged in or not
/// to navigate to the appropriate page at the start of the app.
class RootPage extends StatelessWidget {
  const RootPage();
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listenWhen: (previous, current) =>
          previous is AuthInitialState && current is! AuthInitialState,
      listener: (context, state) {
        if (state is AuthLoggedInState) {
          context.openNamedPageWithClearStack(AppRoutes.MAIN.value);
        } else if (state is AuthLoggedOutState) {
          context.openNamedPageWithClearStack(AppRoutes.AUTH.value);
        }
      },
      child: const LoadingPage(),
    );
  }
}
