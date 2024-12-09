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
  final bool favorite;

  WeatherLoaded({
    required this.weatherNow,
    required this.hourlyForecast,
    required this.dailyForecast,
    required this.city,
    required this.favorite,
  });

  WeatherLoaded copyWith({
    WeatherData? weatherNow,
    List<WeatherData>? hourlyForecast,
    List<WeatherData>? dailyForecast,
    String? city,
    bool? favorite,
  }) {
    return WeatherLoaded(
      weatherNow: weatherNow ?? this.weatherNow,
      hourlyForecast: hourlyForecast ?? this.hourlyForecast,
      dailyForecast: dailyForecast ?? this.dailyForecast,
      city: city ?? this.city,
      favorite: favorite ?? this.favorite,
    );
  }
}

class WeatherError extends CityWeatherState {
  final String message;

  WeatherError(this.message);
}
