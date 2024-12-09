import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/feature/home/bloc/home_page_bloc.dart';
import 'package:flutter_weather_app/presentation/widget/background_widget.dart';

import '../../core/util/time_util.dart';
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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocBuilder<HomePageBloc, HomePageState>(
                        bloc: bloc,
                        builder: (context, state) {
                          final theme = Theme.of(context);
                          if (state is HomeLoaded) {
                            final favorites = state.favorites;
                            if (favorites.isEmpty) {
                              return const SizedBox(
                                height: 50,
                              );
                            }
                            return _FavoritesWidget(favorites: favorites);
                          }
                          if (state is HomeLoading) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (state is HomeError) {
                            return Center(
                              child: Text(
                                state.message,
                                style: theme.textTheme.labelLarge,
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
            ),
          );
        },
      ),
    );
  }
}

class _FavoritesWidget extends StatelessWidget {
  const _FavoritesWidget({
    required this.favorites,
  });

  final List<String> favorites;

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
          color: isDayTime ? theme.primaryColor.withOpacity(0.5) : Colors.black.withOpacity(0.3),
        ),
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.favorite,
                        color: theme.colorScheme.onPrimary,
                        size: 20,
                      ),
                    ),
                    Text(
                      'Check your favourite location',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: favorites.map((city) {
                    return ActionChip(
                      label: Text(
                        city,
                        style: theme.textTheme.bodySmall,
                      ),
                      shape: const StadiumBorder(),
                      backgroundColor: isDayTime ? theme.primaryColor : theme.colorScheme.secondary,
                      disabledColor: isDayTime ? theme.primaryColor : theme.colorScheme.secondary,
                      onPressed: () => context.read<HomePageBloc>().add(OpenCity(city)),
                    );
                  }).toList(),
                ),
              ],
            )),
      ),
    );
  }
}
