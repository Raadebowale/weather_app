import 'package:weather_app/services/api_key.dart';

const baseURL = "https://api.openweathermap.org/data/2.5";
String apiURL(lat, lon) {
  String url;
  url = "$baseURL/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric";
  return url;
}
