import 'package:clock_app/views/screens/clock_page.dart';
import 'package:clock_app/views/screens/buttonpage.dart';
// import 'package:clock_app/views/screens/clockpage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const Buttonpage(),
        // 'clock_page': (context) => StopwatchApp()
        'clock_page': (context) => const Clockpage(),
      },
    );
  }
}
