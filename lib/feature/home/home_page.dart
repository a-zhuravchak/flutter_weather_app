import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/feature/home/bloc/home_page_bloc.dart';
import 'package:flutter_weather_app/presentation/widget/background_widget.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});

  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageBloc(),
      child: BlocConsumer<HomePageBloc, HomePageState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final bloc = context.read<HomePageBloc>();
          return GradientBackground(
            child: Scaffold(
              body:Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search Input Field
                    TextField(
                      controller: _cityController,
                      decoration: const InputDecoration(
                        labelText: 'Enter city name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            final cityName = _cityController.text.trim();
                            if (cityName.isNotEmpty) {
                              bloc.add(FetchWeather(cityName));
                            }
                          },
                          child: const Text('Search'),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () {
                            _cityController.clear();
                            // bloc.add(ClearWeather());
                          },
                          child: const Text('Clear'),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Weather Display
                    Expanded(
                      child: BlocBuilder<HomePageBloc, HomePageState>(
                        bloc: bloc,
                        builder: (context, state) {
                          if (state is WeatherLoading) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (state is WeatherLoaded) {
                            return Center(
                              child: WeatherDisplay(
                                cityName: state.weather.cityName,
                                temperature: state.weather.temperature,
                                condition: state.weather.condition,
                                icon: state.weather.icon,
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
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class WeatherDisplay extends StatelessWidget {
  final String cityName;
  final double temperature;
  final String condition;
  final String icon;

  const WeatherDisplay({
    super.key,
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          cityName,
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          '${temperature.toStringAsFixed(1)}°C',
          style: const TextStyle(fontSize: 48),
        ),
        const SizedBox(height: 10),
        Image.network(
          'https://openweathermap.org/img/wn/$icon@2x.png',
          scale: 1.0,
        ),
        const SizedBox(height: 10),
        Text(
          condition,
          style: const TextStyle(fontSize: 24),
        ),
      ],
    );
  }
}