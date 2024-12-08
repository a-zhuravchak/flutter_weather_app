import 'package:bloc/bloc.dart';
import 'package:flutter_weather_app/domain/entities/weather_entity.dart';
import 'package:flutter_weather_app/domain/repo/weather_repository.dart';
import 'package:meta/meta.dart';

import '../../../core/di/di.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherLoading());
      try {
        final weather = await _repository.getWeather(event.cityName);
        emit(WeatherLoaded(
          weather: weather
        ));
      } catch (e) {
        emit(WeatherError("Failed to fetch weather for '${event.cityName}'."));
      }
    });
  }

  final WeatherRepository _repository = getIt();
}
