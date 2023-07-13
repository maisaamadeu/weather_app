import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/app/pages/weather_page.dart';
import 'package:weather_app/app/shared/theme/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.sunny,
                size: 200,
                color: AppColors.primary,
              ),
              const SizedBox(
                height: 120,
              ),
              Text(
                'Notícias sobre o Clima',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: AppColors.primary,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                ),
              )
                  .animate(
                    onPlay: (controller) => controller.repeat(),
                  )
                  .shimmer(delay: 5000.ms, duration: 1000.ms),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Além de saber como o clima está, poderá se gabar sendo um vidente para seus amigos ao descobrir como o clima estará!',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: Colors.blueGrey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WeatherPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        AppColors.primary, //background color of button
                    elevation: 3, //elevation of button
                    shape: RoundedRectangleBorder(
                      //to set border radius to button
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Começar',
                    style: GoogleFonts.inter(
                      color: AppColors.background,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
                    .animate(
                      onPlay: (controller) => controller.repeat(),
                    )
                    .shimmer(delay: 5000.ms, duration: 1000.ms),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
