import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/app/pages/start_page.dart';
import 'package:weather_app/app/pages/weather_page.dart';
import 'package:weather_app/app/shared/theme/app_colors.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    checkLocation(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/clear.png',
                scale: 1,
              ),
              const SizedBox(
                height: 60,
              ),
              const CircularProgressIndicator(
                color: AppColors.primary,
              ),
              const SizedBox(
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkLocation(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (context.mounted) {
      Timer(
        const Duration(seconds: 2),
        () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => prefs.containsKey('latitude') &&
                      prefs.containsKey('longitude')
                  ? const WeatherPage()
                  : const StartPage(),
            ),
          );
        },
      );
    }
  }
}
