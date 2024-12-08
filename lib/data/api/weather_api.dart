import 'dart:convert';

import '../../core/network/api_client.dart';
import '../../core/util/api_constants.dart';
import '../../domain/entities/weather_entity.dart';

class WeatherApi {
  final ApiClient apiClient;

  WeatherApi(this.apiClient);

  Future<WeatherEntity> fetchWeather(String cityName) async {
    final url = Uri.parse(
        '${ApiConstants.baseUrl}?q=$cityName&appid=${ApiConstants.apiKey}&units=metric');

    final response = await apiClient.get(url);
    if (response.statusCode == 200) {
      return WeatherEntity.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error fetching weather data");
    }
  }
}