import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:weather_app/app/pages/weather_page.dart';
import 'package:weather_app/app/shared/theme/app_colors.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:geolocator/geolocator.dart';

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
              Image.asset(
                'assets/images/clear.png',
                scale: 1,
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
                  onPressed: () async {
                    ph.PermissionStatus permission =
                        await ph.Permission.location.request();
                    if (permission.isGranted) {
                      bool gpsIsEnabled =
                          await Geolocator.isLocationServiceEnabled();
                      print(gpsIsEnabled);

                      if (!gpsIsEnabled) {
                        Alert(
                                context: context,
                                title: 'GPS Desligado',
                                desc:
                                    'Seu GPS está desligado, para obter a localicação ative-o.')
                            .show();
                      } else {
                        Position position =
                            await Geolocator.getCurrentPosition();
                        print(position);
                        Alert(
                                context: context,
                                title: 'GPS Ligado :)',
                                desc: '${position}')
                            .show();
                      }
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const WeatherPage(),
                      //   ),
                      // );
                    } else if (permission.isDenied) {
                      Alert(
                              context: context,
                              title: "Permissão Negada",
                              desc:
                                  "Parece que você não permitiu o uso do GPS, abra as configurações do aplicativo e libere a permissão")
                          .show();
                    }
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
