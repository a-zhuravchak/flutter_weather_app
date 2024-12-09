import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/data/api_exception.dart';
import 'package:flutter_weather_app/domain/repo/weather_repository.dart';
import 'package:flutter_weather_app/presentation/routing/routes.dart';

import '../../../core/di/di.dart';
import '../../../domain/service/city_storage_service.dart';

part 'home_page_event.dart';

part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageEmpty()) {
    on<FetchWeather>((event, emit) async {
      emit(HomeLoading());
      try {
        await _repository.getWeather(city: event.cityName);
        emit(
          HomePagePushRoute(
            route: AppRoutes.cityWeather,
            city: event.cityName.toUpperCase(),
            favorites: _cityStorageService.currentCities,
          ),
        );
      } on APIException catch (e) {
        emit(HomeError(e.message));
      } catch (e) {
        emit(HomeError('Fail ${e.toString()}'));
      }
    });
    on<ClearSelection>((event, emit) {
      emit(HomePageEmpty());
    });
    on<FavoritesUpdated>((event, emit) {
      emit(HomeLoaded(favorites: event.cities));
    });
    on<OpenCity>((event, emit) {
      emit(HomePagePushRoute(
        route: AppRoutes.cityWeather,
        city: event.city.toUpperCase(),
        favorites: _cityStorageService.currentCities,
      ));
    });
    _citiesSubscription = _cityStorageService.citiesStream.listen((cities) {
      add(FavoritesUpdated(cities));
    });
  }

  final WeatherRepository _repository = getIt();
  final CityStorageService _cityStorageService = getIt();
  StreamSubscription<List<String>>? _citiesSubscription;

  @override
  Future<void> close() {
    _citiesSubscription?.cancel();
    return super.close();
  }
}
