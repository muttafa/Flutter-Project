import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Utils/weather.dart';


class MainScreen extends StatefulWidget {



  final WeatherData weatherData;

  MainScreen(@required this.weatherData);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int? temperature;
  Icon? weatherDisplayIcon;
  AssetImage? backgroundImage;

  WeatherData get currentWeatherData => widget.weatherData;

  void updateDisplayInfo(WeatherData weatherData) {
    setState(() {
      temperature = weatherData.currentTemperature?.round();
      WeatherDisplayData? weatherDisplayData = weatherData.getWeatherDataDisplay();
      backgroundImage = weatherDisplayData?.weatherImage;
      weatherDisplayIcon = weatherDisplayData?.weatherIcon;
    });
  }

  @override
  void initState() {
    super.initState();
    updateDisplayInfo(currentWeatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: backgroundImage!,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 40,),
            Container(
              child: weatherDisplayIcon,
            ),
            SizedBox(height: 40,),
            Center(
              child: Text('${temperature}°',style: TextStyle(fontSize: 80),),
            ),
          ],
        ),
      ),
    );
  }
}

