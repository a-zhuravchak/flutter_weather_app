import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/weather_data.dart';

class ForecastWidget extends StatelessWidget {
  const ForecastWidget({
    super.key,
    required this.forecast,
  });

  final List<WeatherData> forecast;

  @override
  Widget build(BuildContext context) {
    if (forecast.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        const Divider(),
        LayoutBuilder(builder: (context, constraints) {
          return SizedBox(
            width: constraints.maxWidth,
            height: 120,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: forecast.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ForecastItem(item: forecast[index]);
                }),
          );
        })
      ],
    );
  }
}

class ForecastItem extends StatelessWidget {
  const ForecastItem({
    super.key,
    required this.item,
  });

  final WeatherData item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            DateFormat('EEEE').format(item.date),
            style: textTheme.bodySmall?.copyWith(color: theme.colorScheme.onPrimary),
          ),
          Text(
            DateFormat('HH:mm').format(item.date),
            style: textTheme.labelSmall?.copyWith(color: theme.colorScheme.onPrimary, fontSize: 12),
          ),
          SizedBox(
            width: 40.0,
            height: 40.0,
            child: Image.network(
              item.iconUrl,
              fit: BoxFit.fitHeight,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error);
              },
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '${item.temp.celsius.toStringAsFixed(0)}°C',
            style: textTheme.bodyMedium,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
