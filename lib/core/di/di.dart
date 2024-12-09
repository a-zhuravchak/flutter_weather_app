import 'package:flutter_weather_app/domain/service/city_storage_service.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/api/weather_api.dart';
import '../../data/repo/weather_repository.dart';
import '../../data/service/city_storage_service.dart';
import '../../domain/repo/weather_repository.dart';
import '../network/api_client.dart';

final getIt = GetIt.instance;

Future<void> setupDI() async {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<ApiClient>(() => ApiClient());
  getIt.registerLazySingleton<WeatherApi>(() => WeatherApi());
  getIt.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      weatherApi: getIt<WeatherApi>(),
      client: getIt<ApiClient>(),
    ),
  );
  getIt.registerLazySingleton<CityStorageService>(
    () => CityStorageServiceImpl(prefs: prefs),
  );
}
