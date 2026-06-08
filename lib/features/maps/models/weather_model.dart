class WeatherModel {
  final String location;
  final double temperature;
  final String weather;
  final String time;

  WeatherModel({
    required this.location,
    required this.temperature,
    required this.weather,
    required this.time,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      location: json['location'] ?? '',
      temperature: (json['temperature'] ?? 0).toDouble(),
      weather: json['weather'] ?? '',
      time: json['time'] ?? '',
    );
  }
}