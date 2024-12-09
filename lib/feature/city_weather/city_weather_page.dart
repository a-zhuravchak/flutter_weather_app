import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/widget/background_widget.dart';
import '../weather/weather_widget.dart';
import '../weather_forecast/day_forecast_widget.dart';
import '../weather_forecast/week_forecast_widget.dart';
import 'bloc/city_weather_bloc.dart';

class CityWeatherPage extends StatelessWidget {
  const CityWeatherPage({super.key, required this.cityName});

  final String cityName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CityWeatherBloc(cityName),
      child: BlocConsumer<CityWeatherBloc, CityWeatherState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final bloc = context.read<CityWeatherBloc>();
          final theme = Theme.of(context);
          return GradientBackground(
            child: Scaffold(
              appBar: AppBar(
                title: Text(cityName.toUpperCase()),
                centerTitle: true,
                leading: BackButton(
                  color: theme.colorScheme.onPrimary,
                ),
                actions: [
                  if (state is WeatherLoaded)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: IconButton(
                        icon: state.favorite
                            ? Icon(
                                Icons.favorite,
                                color: theme.colorScheme.onPrimary,
                              )
                            : Icon(
                                Icons.favorite_border,
                                color: theme.colorScheme.onPrimary,
                              ),
                        onPressed: () => state.favorite
                            ? bloc.add(RemoveFromFavorites())
                            : bloc.add(AddToFavorites()),
                      ),
                    ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Weather Display
                      BlocBuilder<CityWeatherBloc, CityWeatherState>(
                        bloc: bloc,
                        builder: (context, state) {
                          if (state is WeatherLoading) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (state is WeatherLoaded) {
                            return Center(
                              child: Column(
                                children: [
                                  WeatherWidget(
                                    weather: state.weatherNow,
                                    forecast: state.hourlyForecast,
                                    cityName: state.city,
                                  ),
                                  const SizedBox(height: 20),
                                  DayForecastWidget(
                                    forecast: state.hourlyForecast,
                                    cityName: state.city,
                                  ),
                                  const SizedBox(height: 20),
                                  WeekForecastWidget(
                                    forecast: state.dailyForecast,
                                    cityName: state.city,
                                  )
                                ],
                              ),
                            );
                          } else if (state is WeatherError) {
                            return Center(
                              child: Text(
                                state.message,
                                style: const TextStyle(color: Colors.red),
                              ),
                            );
                          } else {
                            return const Center(child: Text('Enter a city to see the weather.'));
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
