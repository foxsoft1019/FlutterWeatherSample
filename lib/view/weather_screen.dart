

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_weather_sample/view-model/weather_view_model.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  @override
  void initState() {

    super.initState();

    Provider.of<WeatherViewModel>(context, listen: false).getCurrentPosition();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final vm = Provider.of<WeatherViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Current Location", style: TextStyle(fontSize: 20, color: Colors.white),),
              const SizedBox(height: 10,),
              Text('Lat: ${vm.latitude},  Lon: ${vm.longitude}', style: const TextStyle(fontSize: 16, color: Colors.white),),
              const SizedBox(height: 20,),
              const Text("Weather Information", style: TextStyle(fontSize: 20, color: Colors.white),),
              const SizedBox(height: 10,),
              if (vm.locationName.isNotEmpty)
                Text(vm.locationName, style: const TextStyle(fontSize: 16, color: Colors.white),),
              if (vm.weatherIconUrl.isNotEmpty)
                Image.network(vm.weatherIconUrl),
              Text('Temperature: ${vm.temperature}', style: const TextStyle(fontSize: 16, color: Colors.white),),
              Text('Wind Speed: ${vm.windSpeed}', style: const TextStyle(fontSize: 16, color: Colors.white),),
              const SizedBox(height: 50,),
              ElevatedButton(
                  onPressed: () {
                    vm.getCurrentPosition();
                  },
                  child: const Icon(Icons.refresh))
            ],
          )
      )
    );
  }
}