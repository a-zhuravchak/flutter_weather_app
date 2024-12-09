# flutter_weather_app

A Flutter Weather App project.

## Project prerequisites

1. [flutter](https://docs.flutter.dev/get-started/install/macos/mobile-ios) framework, project will
   be based on.
2. [fvm](https://fvm.app/documentation/getting-started/installation) is needed to handle flutter
   versioning.

## Prerequisites:

The data layer contains a single HttpWeatherRepository that is used to fetch weather data from the
OpenWeatherMap API.

1. Obtain API Key for OpenWeatherMapAPI
2. Create `.env` in the root folder of the project. If you wish to change it's location be sure to
   update the `pubspec.yaml` assets list.
3. Add following lines to `.env`:

```
   API_KEY=YOUR_API_KEY
```

4. run

```bash
  fvm flutter pub get
```

## Screenshots:

![App Screenshot](assets/S1.jpg)
![App Screenshot](assets/S2.jpg)