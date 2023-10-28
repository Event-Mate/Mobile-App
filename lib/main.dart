import 'package:easy_localization/easy_localization.dart';
import 'package:event_mate/event_mate_app.dart';
import 'package:event_mate/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  final overlayStyle = SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.black,
    statusBarBrightness: Brightness.dark,
  );
  SystemChrome.setSystemUIOverlayStyle(overlayStyle);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final injected = await setupInjection();
  if (injected) {
    runApp(
      EasyLocalization(
        supportedLocales: const [
          Locale('en'),
          Locale('tr'),
        ],
        path: 'assets/languages',
        fallbackLocale: const Locale('en'),
        child: const EventMateApp(),
      ),
    );
  } else {
    throw Exception('Injection failed ❌');
  }
}
