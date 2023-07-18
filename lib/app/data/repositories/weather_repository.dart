import 'dart:convert';
import 'package:weather_app/app/data/http/exceptions.dart';
import 'package:weather_app/app/data/http/http_client.dart';
import 'package:weather_app/app/data/keys/api_keys.dart';
import 'package:weather_app/app/data/models/weather_model.dart';

abstract class IWeatherRepository {
  Future<WeatherModel> getWeather({required double lat, required double lon});
}

class WeatherRepository implements IWeatherRepository {
  final IHttpClient client;

  WeatherRepository({required this.client});

  @override
  Future<WeatherModel> getWeather(
      {required double lat, required double lon}) async {
    final response = await client.get(
        url:
            "https://api.openweathermap.org/data/2.5/weather?lat=-23.2186142&lon=-47.682026&appid=${ApiKeys.weather}");

    if (response.statusCode == 200) {
      try {
        late final WeatherModel weatherModel;

        final body = jsonDecode(response.body);

        weatherModel = WeatherModel.fromJson(body);

        return weatherModel;
      } on Exception catch (e) {
        throw Exception(e);
      }
    } else if (response.statusCode == 404) {
      throw NotFoundException('A URL informada não é válida');
    } else {
      throw Exception('Não foi possível carregar o clima');
    }
  }
}
