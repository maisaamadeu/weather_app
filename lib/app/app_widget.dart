import 'package:flutter/material.dart';
import 'package:weather_app/app/pages/start_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: StartPage(),
    );
  }
}
