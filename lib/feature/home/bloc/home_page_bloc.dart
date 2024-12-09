import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/data/api_exception.dart';
import 'package:flutter_weather_app/domain/repo/weather_repository.dart';
import 'package:flutter_weather_app/presentation/routing/routes.dart';

import '../../../core/di/di.dart';
import '../../../domain/entities/weather_data.dart';

part 'home_page_event.dart';

part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageEmpty()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherLoading());
      try {
        await _repository.getWeather(city: event.cityName);
        emit(HomePagePushRoute(route: AppRoutes.cityWeather, city: event.cityName.toUpperCase()));
      } on APIException catch (e) {
        emit(WeatherError(e.message));
      } catch (e) {
        emit(WeatherError('Fail ${e.toString()}'));
      }
    });
    on<ClearSelection>((event, emit) {
      emit(HomePageEmpty());
    });
  }

  final WeatherRepository _repository = getIt();
}
