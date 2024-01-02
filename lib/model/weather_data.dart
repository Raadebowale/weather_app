import 'package:weather_app/model/weather_data_current.dart';

class WeatherData {
  final WeatherDataCurrent? current;
  const WeatherData([this.current]);

  WeatherDataCurrent getCurrentWeather() => current!;
}
