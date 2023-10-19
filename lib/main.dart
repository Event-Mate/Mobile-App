import 'package:flutter/material.dart';

void main() {
  runApp(const EventMateApp());
}

class EventMateApp extends StatelessWidget {
  const EventMateApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EventMate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        body: Center(child: Text('Starting...')),
      ),
    );
  }
}
