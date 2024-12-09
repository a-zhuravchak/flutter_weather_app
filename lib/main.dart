import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_weather_app/feature/city_weather/city_weather_page.dart';
import 'package:flutter_weather_app/presentation/routing/routes.dart';
import 'package:flutter_weather_app/presentation/theme.dart';

import 'core/di/di.dart';
import 'feature/home/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  setupDI();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      initialRoute: AppRoutes.home,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case AppRoutes.home:
            return MaterialPageRoute(
              builder: (context) => HomePage(),
            );
          case AppRoutes.cityWeather:
            final String routeParam = settings.arguments as String;
            return MaterialPageRoute(
              builder: (context) => CityWeatherPage(cityName: routeParam),
            );
          default:
            return null;
        }
      },
      theme: createTheme(),
      home: HomePage(),
    );
  }
}
