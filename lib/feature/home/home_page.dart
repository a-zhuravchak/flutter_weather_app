import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/feature/home/bloc/home_page_bloc.dart';
import 'package:flutter_weather_app/presentation/widget/background_widget.dart';

import '../../presentation/widget/styled_button.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageBloc(),
      child: BlocConsumer<HomePageBloc, HomePageState>(
        listener: (context, state) {
          if (state is HomePagePushRoute) {
            Navigator.pushNamed(
              context,
              state.route,
              arguments: state.city,
            );
          }
        },
        builder: (context, state) {
          final bloc = context.read<HomePageBloc>();
          return GradientBackground(
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Weather Display
                    BlocBuilder<HomePageBloc, HomePageState>(
                      bloc: bloc,
                      builder: (context, state) {
                        if (state is WeatherLoading) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (state is WeatherError) {
                          return Center(
                            child: Text(
                              state.message,
                              style: const TextStyle(color: Colors.red),
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    // Search Input Field
                    TextField(
                      controller: _cityController,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: const InputDecoration(
                        hintText: 'Find your city',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),

                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: StyledButton(
                            text: 'SEARCH',
                            onTap: () {
                              final cityName = _cityController.text.trim();
                              if (cityName.isNotEmpty) {
                                bloc.add(FetchWeather(cityName));
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
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
