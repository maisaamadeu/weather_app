import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/app/pages/weather_page.dart';
import 'package:weather_app/app/shared/theme/app_colors.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/plugin_api.dart';

class StartPage extends StatefulWidget {
  StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  late SharedPreferences prefs;
  final mapController = MapController();
  LatLng markerPosition = LatLng(-23.506989, -46.704630);

  void _handleTap(TapPosition tap, LatLng point) {
    markerPosition = point;
  }

  void getLocation(BuildContext context) async {
    ph.PermissionStatus permission = await ph.Permission.location.request();

    if (permission.isGranted) {
      bool gpsIsEnabled = await Geolocator.isLocationServiceEnabled();

      if (!gpsIsEnabled) {
        if (context.mounted) {
          showCustomModalBottomSheet(
            context: context,
            title: 'GPS Desligado',
            description:
                'Seu GPS está desligado, para obtermos sua localicação é necessário que ative-o.',
            titleButton1: 'Selecionar a localização no mapa',
            functionButton1: () {
              showModalBottomSheetLocation(context);
            },
            titleButton2: 'Ativei o GPS',
            functionButton2: () {
              Navigator.pop(context);
            },
            enableButton1: true,
            enableButton2: true,
          );
        }
      } else {
        if (context.mounted) {
          try {
            Position position = await Geolocator.getCurrentPosition();
            saveLocation(position.latitude, position.longitude);
            if (context.mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const WeatherPage(),
                ),
              );
            }
          } on Exception catch (e) {
            Exception(e);
          }
        }
      }
    } else if (permission.isDenied) {
      if (context.mounted) {
        showCustomModalBottomSheet(
          context: context,
          title: 'Permissão negada',
          description:
              'Parece que você não permitiu o uso do GPS, abra as configurações do aplicativo e libere a permissão.',
          titleButton1: 'Selecionar a localização no mapa',
          functionButton1: () {
            showModalBottomSheetLocation(context);
          },
          titleButton2: 'Permiti o uso do GPS',
          functionButton2: () {
            Navigator.pop(context);
          },
          enableButton1: true,
          enableButton2: true,
        );
      }
    }
  }

  Future<dynamic> showCustomModalBottomSheet({
    required BuildContext context,
    required String title,
    required String description,
    bool enableButton1 = false,
    String titleButton1 = '',
    VoidCallback? functionButton1,
    Color colorButton1 = Colors.red,
    bool enableButton2 = false,
    String titleButton2 = '',
    VoidCallback? functionButton2,
    Color colorButton2 = Colors.green,
    Widget? child,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          top: 10,
          left: 25,
          right: 25,
          bottom: 10,
        ),
        child: Wrap(
          children: [
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
            const Divider(),
            Text(
              description,
              style: GoogleFonts.inter(
                fontSize: 18,
              ),
            ),
            Divider(),
            child ?? Container(),
            child != null ? Divider() : Container(),
            Column(
              children: [
                enableButton1
                    ? SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: functionButton1 ?? () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorButton1,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            titleButton1,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 20,
                              // fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: enableButton1 ? 5 : 0,
                ),
                enableButton2
                    ? SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: functionButton2 ?? () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorButton2,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            titleButton2,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 20,
                              // fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showModalBottomSheetLocation(BuildContext context) {
    Navigator.pop(context);
    showCustomModalBottomSheet(
      context: context,
      title: 'Selecione sua localização no mapa',
      description: 'Clique aonde você deseja saber como está o clima 😉',
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.sizeOf(context).height * 0.5,
        child: StatefulBuilder(builder: (context, setState) {
          return FlutterMap(
            mapController: mapController,
            options: MapOptions(
              center: LatLng(-23.506989, -46.704630),
              zoom: 5,
              onTap: (tapPosition, point) {
                _handleTap(tapPosition, point);
                setState(() {});
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: markerPosition,
                    width: 80,
                    height: 80,
                    builder: (context) => Icon(
                      Icons.location_on,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
      titleButton1: 'Usar esta localização',
      functionButton1: () {
        try {
          saveLocation(markerPosition.latitude, markerPosition.longitude);
          if (context.mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const WeatherPage(),
              ),
            );
          }
        } on Exception catch (e) {
          Exception(e);
        }
      },
      enableButton1: true,
      enableButton2: false,
    );
  }

  void saveLocation(double lag, double lng) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setDouble('latitude', lag);
    prefs.setDouble('longitude', lng);
  }

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
                  onPressed: () {
                    getLocation(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
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

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }
}
