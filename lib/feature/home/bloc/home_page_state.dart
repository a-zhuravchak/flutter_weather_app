part of 'home_page_bloc.dart';

@immutable
sealed class HomePageState {}

final class HomePageEmpty extends HomePageState {}

class WeatherLoading extends HomePageState {}

class WeatherLoaded extends HomePageState {
  final WeatherData weatherNow;
  final List<WeatherData> forecast;
  final String city;

  WeatherLoaded({
    required this.weatherNow,
    required this.forecast,
    required this.city,
  });
}

class HomePagePushRoute extends HomePageState {
  final String route;
  final String city;

  HomePagePushRoute({
    required this.route,
    required this.city,
  });
}

class WeatherError extends HomePageState {
  final String message;

  WeatherError(this.message);
}
