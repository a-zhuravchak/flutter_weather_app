import 'package:flutter_weather_app/domain/entities/forecast.dart';

import '../entities/weather_entity.dart';

abstract class WeatherRepository {
  Future<Weather> getWeather({required String city});

  Future<Forecast> getForecast({required String city});
}
