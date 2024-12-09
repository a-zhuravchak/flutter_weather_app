import 'package:flutter/material.dart';
import '../../core/util/time_util.dart';
import '../../domain/entities/weather_data.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({
    super.key,
    required this.weather,
    required this.forecast,
    required this.cityName,
  });

  final WeatherData weather;
  final List<WeatherData> forecast;
  final String cityName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDayTime = TimeUtils.isDayTime();
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.05),
              blurRadius: 0.8,
              spreadRadius: 0.5,
              offset: const Offset(0, 2),
            )
          ],
          color: isDayTime ? theme.primaryColor : Colors.black.withOpacity(0.3),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              WeatherDisplay(
                cityName: cityName,
                data: weather,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WeatherDisplay extends StatelessWidget {
  final String cityName;
  final WeatherData data;

  const WeatherDisplay({
    super.key,
    required this.cityName,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final icon = data.iconUrl;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${data.temp.celsius.toStringAsFixed(0)}°C',
            style: textTheme.titleLarge?.copyWith(fontSize: 70),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                icon,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
                },
                width: 50.0,
                height: 50.0,
                scale: 0.3,
              ),
              Text(
                data.description,
                style: textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
