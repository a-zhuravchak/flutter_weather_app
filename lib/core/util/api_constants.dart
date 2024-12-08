import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String get baseUrl => "https://api.openweathermap.org/data/2.5/weather";
  static String get apiKey => dotenv.env['API_KEY']!;
}