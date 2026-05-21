import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart';

class WeatherRepository {
  // Get your free API key from https://openweathermap.org/api
  final String apiKey = "dceb401fa15ff40b305591b015e300a7";

  Future<Weather> fetchWeather(String city) async {
    final url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";

    final response = await http.get(Uri.parse(url));

    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load weather");
    }
  }
}
