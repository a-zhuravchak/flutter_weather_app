import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/domain/service/city_storage_service.dart';

import '../../../core/di/di.dart';
import '../../../data/api_exception.dart';
import '../../../domain/entities/city_weather.dart';
import '../../../domain/entities/weather_data.dart';
import '../../../domain/repo/weather_repository.dart';

part 'city_weather_event.dart';

part 'city_weather_state.dart';

class CityWeatherBloc extends Bloc<CityWeatherEvent, CityWeatherState> {
  CityWeatherBloc(this.cityName) : super(WeatherLoading()) {
    on<FetchWeather>((event, emit) async {
      try {
        final weather = await _repository.getWeather(city: event.cityName);
        final forecast = await _repository.getForecast(city: event.cityName);

        final cityWeather = CityWeather.from(
          weather: WeatherData.from(weather),
          forecast: forecast.list.map((item) => WeatherData.from(item)).toList(),
          cityName: cityName,
        );

        final favorite = _cityStorageService.currentCities.contains(cityName);

        emit(WeatherLoaded(
          weatherNow: cityWeather.weatherNow,
          hourlyForecast: cityWeather.hourlyForecast,
          dailyForecast: cityWeather.dailyForecast,
          city: cityWeather.city,
          favorite: favorite,
        ));
      } on APIException catch (e) {
        emit(WeatherError(e.message));
      } catch (e) {
        emit(WeatherError('Fail ${e.toString()}'));
      }
    });
    on<AddToFavorites>((event, emit) async {
      _cityStorageService.addCity(cityName);

      final currentState = state;
      if (currentState is WeatherLoaded) {
        emit(currentState.copyWith(favorite: true));
      }
    });
    on<RemoveFromFavorites>((event, emit) async {
      _cityStorageService.removeCity(cityName);

      final currentState = state;
      if (currentState is WeatherLoaded) {
        emit(currentState.copyWith(favorite: false));
      }
    });

    add(FetchWeather(cityName));
  }

  final WeatherRepository _repository = getIt();
  final CityStorageService _cityStorageService = getIt();
  final String cityName;
}
