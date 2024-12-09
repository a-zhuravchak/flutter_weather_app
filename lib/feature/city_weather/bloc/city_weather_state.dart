part of 'city_weather_bloc.dart';

@immutable
sealed class CityWeatherState {}

final class HomePageEmpty extends CityWeatherState {}

class WeatherLoading extends CityWeatherState {}

class WeatherLoaded extends CityWeatherState {
  final WeatherData weatherNow;
  final List<WeatherData> hourlyForecast;
  final List<WeatherData> dailyForecast;
  final String city;

  WeatherLoaded({
    required this.weatherNow,
    required this.hourlyForecast,
    required this.dailyForecast,
    required this.city,
  });
}

class WeatherError extends CityWeatherState {
  final String message;

  WeatherError(this.message);
}
