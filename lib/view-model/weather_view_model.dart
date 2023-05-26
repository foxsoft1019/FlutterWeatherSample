
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_weather_sample/apiClient.dart';
import 'package:flutter_weather_sample/constants/constants.dart';
import 'package:flutter_weather_sample/constants/method.dart';
import 'package:flutter_weather_sample/entities/response_entity.dart';
import 'package:geolocator/geolocator.dart';

class WeatherViewModel extends ChangeNotifier {

  String latitude = "";
  String longitude = "";
  String weatherIconUrl = "";
  String windSpeed = "";
  String temperature = "";
  String locationName = "";

  // Get Location Data
  Future<void> getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;

    Position currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    latitude = '${currentPosition.latitude ?? ""}';
    longitude = '${currentPosition.longitude ?? ""}';
    notifyListeners();
    await getWeatherInfo(latitude, longitude);
  }

  // Get Weather Data
  Future<void> getWeatherInfo(String lat, String lon) async {
    String apiUrl = '${Constants.apiMainURL}&lat=$lat&lon=$lon';
    ResponseEntity responseEntity = await ApiClient().request(apiUrl, Method.getMethod, null);
    if (responseEntity.statusCode == 200) {
      final responseData = jsonDecode(responseEntity.responseJson);
      weatherIconUrl = 'http://openweathermap.org/img/w/${responseData['weather'][0]['icon']}.png';
      windSpeed = '${responseData['wind']['speed']}';
      temperature = '${responseData['main']['temp']}';
      locationName = responseData['name'];
      notifyListeners();
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }
}