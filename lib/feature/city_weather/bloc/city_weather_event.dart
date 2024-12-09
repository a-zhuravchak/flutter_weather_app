part of 'city_weather_bloc.dart';

@immutable
sealed class CityWeatherEvent {}

class FetchWeather extends CityWeatherEvent {
  final String cityName;

  FetchWeather(this.cityName);
}
