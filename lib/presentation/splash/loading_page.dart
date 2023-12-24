part of 'package:event_mate/event_mate_app.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.primary,
      body: Center(
        child: DefaultTextStyle(
          style: TextStyle(
            fontSize: 30.0,
            color: context.colors.background,
            fontWeight: FontWeight.bold,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText(
                    env.APP_TITLE,
                    speed: const Duration(milliseconds: 200),
                  ),
                ],
                repeatForever: true,
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.4,
                child: LinearProgressIndicator(
                  backgroundColor: context.colors.tertiary,
                  color: context.colors.background,
                  minHeight: 20,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
