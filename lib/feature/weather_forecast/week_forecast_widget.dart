import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/util/time_util.dart';
import '../../domain/entities/weather_data.dart';

class WeekForecastWidget extends StatelessWidget {
  const WeekForecastWidget({
    super.key,
    required this.forecast,
    required this.cityName,
  });

  final List<WeatherData> forecast;
  final String cityName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
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
          color: isDayTime ? theme.primaryColor.withOpacity(0.5) : Colors.black.withOpacity(0.3),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.calendar_today_outlined,
                      color: theme.colorScheme.onPrimary,
                      size: 20,
                    ),
                  ),
                  Text(
                    'In the next few days',
                    style: textTheme.bodyMedium,
                  ),
                ],
              ),
              _WeekForecastList(
                forecast: forecast,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WeekForecastList extends StatelessWidget {
  const _WeekForecastList({
    required this.forecast,
  });

  final List<WeatherData> forecast;

  @override
  Widget build(BuildContext context) {
    if (forecast.isEmpty) {
      return const SizedBox.shrink();
    }

    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        width: constraints.maxWidth,
        height: 120,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: forecast.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return _ForecastItem(item: forecast[index]);
            }),
      );
    });
  }
}

class _ForecastItem extends StatelessWidget {
  const _ForecastItem({
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
            DateFormat('E').format(item.date),
            style: textTheme.bodySmall?.copyWith(color: theme.colorScheme.onPrimary),
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
