import 'package:get_it/get_it.dart';

import '../../data/api/weather_api.dart';
import '../../data/repo/weather_repository.dart';
import '../../domain/repo/weather_repository.dart';
import '../network/api_client.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<ApiClient>(() => ApiClient());
  getIt.registerLazySingleton<WeatherApi>(() => WeatherApi());
  getIt.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      weatherApi: getIt<WeatherApi>(),
      client: getIt<ApiClient>(),
    ),
  );
}
