part of 'package:event_mate/event_mate_app.dart';

class RootPage extends StatelessWidget {
  const RootPage();
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
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
