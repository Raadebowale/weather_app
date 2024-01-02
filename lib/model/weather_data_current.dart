class WeatherDataCurrent {
  final Main current;
  const WeatherDataCurrent({required this.current});
  factory WeatherDataCurrent.fromJson(Map<String, dynamic> json) =>
      WeatherDataCurrent(current: Main.fromJson(json));
}

class Main {
  int? temp;
  int? humidity;
  int? clouds;
  // Wind? wind;
  double? windSpeed;
  List<Weather>? weather;

  Main({
    this.temp,
    this.humidity,
    this.clouds,
    this.windSpeed,
    this.weather,
  });

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: (json['main']['temp'] as num?)?.round(),
        humidity: json['main']['humidity'] as int?,
        clouds: json['clouds']['all'] as int?,
        // wind: (json['wind'] as num?)?.toDouble(),
        windSpeed: (json['wind']['speed'] as num?)?.toDouble(),
        weather: (json['weather'] as List<dynamic>?)
            ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'main' 'temp': temp,
        'main' 'humidity': humidity,
        'clouds' 'all': clouds,
        'wind' 'speed': windSpeed,
        'weather': weather?.map((e) => e.toJson()).toList(),
      };
}

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"] as int?,
        main: json["main"] as String?,
        description: json["description"] as String?,
        icon: json["icon"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
      };
}
