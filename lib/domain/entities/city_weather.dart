import 'package:flutter_weather_app/domain/entities/weather_data.dart';

class CityWeather {
  final WeatherData weatherNow;
  final List<WeatherData> hourlyForecast;
  final List<WeatherData> dailyForecast;
  final String city;

  CityWeather({
    required this.weatherNow,
    required this.hourlyForecast,
    required this.dailyForecast,
    required this.city,
  });

  factory CityWeather.from({
    required WeatherData weather,
    required List<WeatherData> forecast,
    required String cityName,
  }) {
    final now = DateTime.now();
    final today = now.day;

    final hourlyForecast = forecast.where((item) => item.date.day == today).toList();

    final Map<int, WeatherData> dailyMap = {};
    for (var item in forecast) {
      if (!dailyMap.containsKey(item.date.day)) {
        dailyMap[item.date.day] = item;
      }
    }
    final dailyForecast = dailyMap.values.toList();

    return CityWeather(
      weatherNow: weather,
      hourlyForecast: hourlyForecast,
      dailyForecast: dailyForecast,
      city: cityName.toUpperCase(),
    );
  }
}
