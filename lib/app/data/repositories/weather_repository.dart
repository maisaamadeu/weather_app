import 'dart:convert';
import 'package:weather_app/app/data/http/exceptions.dart';
import 'package:weather_app/app/data/http/http_client.dart';
import 'package:weather_app/app/data/keys/api_keys.dart';
import 'package:weather_app/app/data/models/weather_model.dart';

abstract class IWeatherRepository {
  Future<WeatherModel> getWeather();
}

class WeatherRepository implements IWeatherRepository {
  final IHttpClient client;

  WeatherRepository({required this.client});

  @override
  Future<WeatherModel> getWeather() async {
    final response = await client.get(
        url:
            "https://api.openweathermap.org/data/2.5/weather?lat=-23.2186142&lon=-47.682026&appid=${ApiKeys.weather}");

    if (response.statusCode == 200) {
      late final WeatherModel weatherModel;

      final body = jsonDecode(response.body);

      body.map((weather) {
        weatherModel = WeatherModel.fromJson(weather);
      });

      return weatherModel;
    } else if (response.statusCode == 404) {
      throw NotFoundException('A URL informada não é válida');
    } else {
      throw Exception('Não foi possível carregar o clima');
    }
  }
}
