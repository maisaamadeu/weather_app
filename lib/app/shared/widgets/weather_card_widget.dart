import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/app/shared/theme/app_colors.dart';

class WeatherCardWidget extends StatelessWidget {
  const WeatherCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassContainer.clearGlass(
      height: 260,
      width: MediaQuery.sizeOf(context).width,
      borderRadius: BorderRadius.circular(20),
      elevation: 20,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(0.15),
          Colors.white.withOpacity(0.05),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Hoje',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '14/04/2023',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14,
                  // fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '30',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 60,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 7),
                    child: Text(
                      '°C',
                      style: GoogleFonts.inter(
                        color: AppColors.primary,
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Image.asset(
                'assets/images/clear.png',
                scale: 1.5,
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_on_rounded,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                'Boituva, SP - Brasil',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14,
                  // fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
