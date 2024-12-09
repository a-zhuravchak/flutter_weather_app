abstract class CityStorageService {
  Future<void> init();

  Stream<List<String>> get citiesStream;

  List<String> get currentCities;

  Future<void> addCity(String city);

  Future<void> removeCity(String city);

  void dispose();
}
