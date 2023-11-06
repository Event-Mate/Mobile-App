part of 'package:event_mate/event_mate_app.dart';

class SplashPage extends StatelessWidget {
  const SplashPage();
  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashLoadedState) {
          context.openNamedPageWithClearStack(AppRoutes.ROOT.value);
        }
      },
      child: const LoadingPage(),
    );
  }
}
