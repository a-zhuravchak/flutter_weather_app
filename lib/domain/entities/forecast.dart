import 'package:flutter_weather_app/domain/entities/weather_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forecast.g.dart';

@JsonSerializable(createToJson: false)
class Forecast {
  Forecast({
    required this.list,
  });

  final List<Weather> list;

  factory Forecast.fromJson(Map<String, dynamic> json) => _$ForecastFromJson(json);
}
