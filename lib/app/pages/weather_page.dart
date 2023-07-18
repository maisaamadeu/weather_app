import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/app/shared/theme/app_colors.dart';
import 'package:weather_app/app/shared/widgets/weather_card_widget.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({
    super.key,
  });

  // var response = await WeatherRepository(client: HttpClient())
  // .getWeather(lat: position.latitude, lon: position.longitude);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Clima',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.background,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.edit_location_alt_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              WeatherCardWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
