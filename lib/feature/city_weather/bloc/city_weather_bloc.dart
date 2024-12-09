import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

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

        // Create CityWeather using the factory constructor
        final cityWeather = CityWeather.from(
          weather: WeatherData.from(weather),
          forecast: forecast.list.map((item) => WeatherData.from(item)).toList(),
          cityName: cityName,
        );

        // Emit the final state
        emit(WeatherLoaded(
          weatherNow: cityWeather.weatherNow,
          hourlyForecast: cityWeather.hourlyForecast,
          dailyForecast: cityWeather.dailyForecast,
          city: cityWeather.city,
        ));
      } on APIException catch (e) {
        emit(WeatherError(e.message));
      } catch (e) {
        emit(WeatherError('Fail ${e.toString()}'));
      }
    });

    add(FetchWeather(cityName));
  }

  final WeatherRepository _repository = getIt();
  final String cityName;
}
