

import 'package:flutter_weather_sample/view-model/weather_view_model.dart';
import 'package:get/get.dart';
import 'package:flutter_weather_sample/view/splash_screen.dart';
import 'package:flutter_weather_sample/view/weather_screen.dart';
import 'package:provider/provider.dart';

class RouteHelper {
  static const splashScreen = '/splash-screen';
  static const weatherScreen = "/weather-screen";

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    // GetPage(name: weatherScreen, page: () => const WeatherScreen()),
    GetPage(name: weatherScreen, page: () => ChangeNotifierProvider(
        create: (context) => WeatherViewModel(),
        child: const WeatherScreen(),
      )
    )
  ];
}