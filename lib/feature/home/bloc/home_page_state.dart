part of 'home_page_bloc.dart';

@immutable
sealed class HomePageState {}

final class HomePageEmpty extends HomePageState {}

class HomeLoading extends HomePageState {}

class HomeLoaded extends HomePageState {
  final List<String> favorites;

  HomeLoaded({
    required this.favorites,
  });
}

class HomePagePushRoute extends HomeLoaded {
  final String route;
  final String city;

  HomePagePushRoute({
    required this.route,
    required this.city,
    required super.favorites,
  });
}

class HomeError extends HomePageState {
  final String message;

  HomeError(this.message);
}
