import 'dart:convert';

import '../../core/network/api_client.dart';
import '../../domain/entities/forecast.dart';
import '../../domain/entities/weather_entity.dart';
import '../../domain/repo/weather_repository.dart';
import '../api/weather_api.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherApi weatherApi;
  final ApiClient client;

  WeatherRepositoryImpl({
    required this.weatherApi,
    required this.client,
  });

  @override
  Future<Forecast> getForecast({required String city}) => _getData(
        uri: weatherApi.forecast(city),
        builder: (dynamic data) => Forecast.fromJson(data),
      );

  @override
  Future<Weather> getWeather({required String city}) => _getData(
        uri: weatherApi.weather(city),
        builder: (dynamic data) => Weather.fromJson(data),
      );

  Future<T> _getData<T>({
    required Uri uri,
    required T Function(Map<String, dynamic> data) builder,
  }) async {
    try {
      final response = await client.get(uri);

      switch (response.statusCode) {
        case 200:
          if (response.body.isEmpty) {
            throw Exception('Empty response');
          }

          final data = json.decode(response.body);
          if (data is Map<String, dynamic>) {
            return builder(data);
          } else {
            throw Exception('Unexpected data format: $data');
          }

        case 401:
          throw Exception('Unauthorized access (401)');
        default:
          throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }
}
