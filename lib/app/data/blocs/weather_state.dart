import 'package:weather_app/app/data/models/weather_model.dart';

abstract class WeatherState {
  final WeatherModel? weather;

  WeatherState({required this.weather});
}

class WeatherInitialState extends WeatherState {
  WeatherInitialState() : super(weather: null);
}

class WeatherLoadingState extends WeatherState {
  WeatherLoadingState() : super(weather: null);
}

class WeatherLoadedState extends WeatherState {
  WeatherLoadedState({required WeatherModel weather}) : super(weather: weather);
}

class WeatherErrorState extends WeatherState {
  final Exception exception;
  WeatherErrorState({required this.exception}) : super(weather: null);
}
