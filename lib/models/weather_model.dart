class Weather {
  // three important things we need to know more about any particular weather
  final String cityName;
  final double temperature;
  final String mainCondition; // whether cloudy, sunny , etc

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
  });

  // method to deal with the Json file (API) to decode information
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
    );
  }
}
