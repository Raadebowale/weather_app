import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_app/model/weather_data.dart';
import 'package:weather_app/services/fetch_weather_api.dart';

class GlobalController extends GetxController {
  final RxBool _isLoading = true.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;

  RxBool checkLoading() => _isLoading;
  RxDouble getLatitude() => _latitude;
  RxDouble getLongitude() => _longitude;

  final weatherData = const WeatherData().obs;

  WeatherData getData() => weatherData.value;

  @override
  void onInit() {
    if (_isLoading.isTrue) {
      getLocation();
    }
    super.onInit();
  }

  getLocation() async {
    bool isServiceEnabled;

    LocationPermission locationPermission;
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      return Future.error("Location not enabled");
    }
    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location permission are denied forever");
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Location permission is denied");
      }
    }

    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then(
      (value) {
        _latitude.value = value.latitude;
        _longitude.value = value.longitude;
        // calling weather api
        return FetchWeatherApi()
            .processData(value.latitude, value.longitude)
            .then(
          (value) {
            weatherData.value = value;
            _isLoading.value = false;
          },
        );
      },
    );
  }
}
