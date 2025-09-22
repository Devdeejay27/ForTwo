import 'package:flutter/material.dart';
import 'package:fortwo/models/weather_model.dart';
import 'package:fortwo/services/weather_service.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // api key
  final _weatherService = WeatherService(apiKey: '47050a0');
  Weather? _weather;

  // fetch weather
  _fetchWeather() async {
    // get the current city
    String cityName = await _weatherService.getCurrentCity();

    // get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    // any errors
    catch (e) {
      debugPrint(e.toString()); // prints errors to my console
    }
  }

  // weather animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null)
      return 'assets/wind.json'; // default set to sunny

    switch (mainCondition.toLowerCase()) {
      // cloudy cases
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';

      // rainy cases
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/wind.json';

      // thunder cases
      case 'thunderstorm':
        return 'assets/lightning.json';

      // sunny cases
      case 'clear':
        return 'assets/sun.json';
      default:
        return 'assets/sun.json';
    }
  }

  // init state
  @override
  void initState() {
    super.initState();

    // fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // city name
            Text(_weather?.cityName ?? 'loading city...'),

            // animation
            SizedBox(
                height: 200,
                child:
                    Lottie.asset(getWeatherAnimation(_weather?.mainCondition))),

            // temperature
            Text(_weather != null
                ? '${_weather!.temperature.round()}°C' // added a null check to display temperature if not null
                : 'loading temperature...'),

            // weather condition
            Text(_weather?.mainCondition ?? ''),
          ],
        ),
      ),
    );
  }
}
