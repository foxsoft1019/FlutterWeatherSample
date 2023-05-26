
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_weather_sample/route.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<void> goNextPage() async {
    Timer(const Duration(seconds: 2), () async {
      Get.offAndToNamed(RouteHelper.weatherScreen);
    });
  }

  @override
  void initState() {
    super.initState();

    goNextPage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text('Weather Sample', style: TextStyle(fontSize: 24, color: Colors.blue),),
            ],
          ),
        )
    );
  }
}