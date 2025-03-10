import 'package:json_annotation/json_annotation.dart';

part 'weather_entity.g.dart';

@JsonSerializable()
class WeatherParams {
  final double temp;

  @JsonKey(name: 'temp_min')
  final double tempMin;

  @JsonKey(name: 'temp_max')
  final double tempMax;

  WeatherParams({
    required this.temp,
    required this.tempMin,
    required this.tempMax,
  });

  factory WeatherParams.fromJson(Map<String, dynamic> json) => _$WeatherParamsFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherParamsToJson(this);
}

// WeatherInfo class
@JsonSerializable()
class WeatherInfo {
  final String main;
  final String description;
  final String icon;

  WeatherInfo({
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) => _$WeatherInfoFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherInfoToJson(this);
}

// Weather class
@JsonSerializable()
class Weather {
  @JsonKey(name: 'main')
  final WeatherParams weatherParams;

  @JsonKey(name: 'weather')
  final List<WeatherInfo> weatherInfo;

  final int dt;

  Weather({
    required this.weatherParams,
    required this.weatherInfo,
    required this.dt,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}
