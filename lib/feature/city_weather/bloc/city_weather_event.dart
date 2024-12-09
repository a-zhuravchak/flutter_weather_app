part of 'city_weather_bloc.dart';

@immutable
sealed class CityWeatherEvent {}

class FetchWeather extends CityWeatherEvent {
  final String cityName;

  FetchWeather(this.cityName);
}

class AddToFavorites extends CityWeatherEvent {}

class RemoveFromFavorites extends CityWeatherEvent {}
