import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/service/city_storage_service.dart';

const String _citiesKey = 'tracked_cities';

class CityStorageServiceImpl implements CityStorageService {
  CityStorageServiceImpl({required this.prefs}) {
    init();
  }

  final SharedPreferences? prefs;

  final BehaviorSubject<List<String>> _citiesStreamController = BehaviorSubject<List<String>>();

  @override
  Future<void> init() async {
    _loadCitiesFromPrefs();
  }

  @override
  Stream<List<String>> get citiesStream => _citiesStreamController.stream;

  @override
  List<String> get currentCities => _citiesStreamController.valueOrNull ?? [];

  @override
  Future<void> addCity(String city) async {
    if (city.isEmpty) return;

    final List<String> updatedCities = List.from(currentCities);
    if (!updatedCities.contains(city)) {
      updatedCities.add(city);
      await _saveCitiesToPrefs(updatedCities);
      _citiesStreamController.add(updatedCities);
    }
  }

  @override
  Future<void> removeCity(String city) async {
    final List<String> updatedCities = List.from(currentCities)..removeWhere((c) => c == city);

    await _saveCitiesToPrefs(updatedCities);
    _citiesStreamController.add(updatedCities);
  }

  void _loadCitiesFromPrefs() {
    final List<String>? cities = prefs?.getStringList(_citiesKey);
    _citiesStreamController.add(cities ?? []);
  }

  Future<void> _saveCitiesToPrefs(List<String> cities) async {
    await prefs?.setStringList(_citiesKey, cities);
  }

  @override
  void dispose() {
    _citiesStreamController.close();
  }
}
