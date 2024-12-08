part of 'home_page_bloc.dart';

@immutable
sealed class HomePageEvent {}

class FetchWeather extends HomePageEvent {
  final String cityName;

  FetchWeather(this.cityName);
}
