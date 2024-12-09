part of 'home_page_bloc.dart';

@immutable
sealed class HomePageEvent {}

class FetchWeather extends HomePageEvent {
  final String cityName;

  FetchWeather(this.cityName);
}

class OpenCity extends HomePageEvent {
  final String city;

  OpenCity(this.city);
}

class ClearSelection extends HomePageEvent {}

class FavoritesUpdated extends HomePageEvent {
  final List<String> cities;

  FavoritesUpdated(this.cities);
}
