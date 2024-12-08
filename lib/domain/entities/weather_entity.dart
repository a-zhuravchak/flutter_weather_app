class WeatherEntity {
  final String cityName;
  final double temperature;
  final String condition;
  final String icon;

  WeatherEntity({
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.icon,
  });

  factory WeatherEntity.fromJson(Map<String, dynamic> json) {
    return WeatherEntity(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      condition: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
    );
  }

}

