import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather_data.dart';
import 'package:weather_app/model/weather_data_current.dart';
import 'package:weather_app/services/api_url.dart';

class FetchWeatherApi {
  WeatherData? weatherData;
  Future<WeatherData> processData(lat, lon) async {
    final response = await http.get(Uri.parse(apiURL(lat, lon)));
    final jsonString = jsonDecode(response.body);
    weatherData = WeatherData(WeatherDataCurrent.fromJson(jsonString));

    return weatherData!;
  }
}
