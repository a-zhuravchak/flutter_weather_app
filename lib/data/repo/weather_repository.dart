import '../../domain/entities/weather_entity.dart';
import '../../domain/repo/weather_repository.dart';
import '../api/weather_api.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherApi weatherApi;

  WeatherRepositoryImpl(this.weatherApi);

  @override
  Future<WeatherEntity> getWeather(String cityName) async {
    final model = await weatherApi.fetchWeather(cityName);
    return WeatherEntity(
      cityName: model.cityName,
      temperature: model.temperature,
      condition: model.condition,
      icon: model.icon,
    );
  }
}