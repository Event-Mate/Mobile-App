part of 'package:event_mate/event_mate_app.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.primary,
      body: Center(
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
          child: AnimatedTextKit(
            animatedTexts: [
              FlickerAnimatedText("${env.APP_TITLE} 🥳"),
            ],
            repeatForever: true,
          ),
        ),
      ),
    );
  }
}
