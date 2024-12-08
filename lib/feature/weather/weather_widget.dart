import 'package:flutter/material.dart';
import '../../domain/entities/weather_data.dart';
import '../weather_forecast/weather_forecast_widget.dart';

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
          color: theme.primaryColor,
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
              ForecastWidget(
                forecast: forecast,
              )
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(
          icon,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.error);
          },
          width: 40.0,
          height: 40.0,
        ),
        const SizedBox(width: 10),
        Text(
          cityName,
          style: textTheme.titleLarge,
        ),
        const SizedBox(width: 10),
        const Spacer(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${data.temp.celsius.toStringAsFixed(1)}°C',
              style: textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Text(
              data.description,
              style: textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }
}
