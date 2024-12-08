part of 'home_page_bloc.dart';

@immutable
sealed class HomePageState {}

final class HomePageInitial extends HomePageState {}


class WeatherLoading extends HomePageState {}

class WeatherLoaded extends HomePageState {
  final WeatherEntity weather;

  WeatherLoaded({
    required this.weather
  });
}

class WeatherError extends HomePageState {
  final String message;

  WeatherError(this.message);
}