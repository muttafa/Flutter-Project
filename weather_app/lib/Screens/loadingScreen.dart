import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/Screens/mainScreen.dart';
import 'package:weather_app/Utils/location.dart';
import 'package:weather_app/Utils/weather.dart';


class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  LocationHelper? locationData;

  Future<void> getlocationData() async {
    locationData = LocationHelper();
    await locationData?.getcurrentLocation();

    if(locationData?.latitude == null || locationData?.longitude == null){
      print("Konum bilgileri gelmedi");
    }else{
      print("Longitude : ${locationData?.longitude}");
      print("Latitude : ${locationData?.latitude}");
    }

  }

  void getWeather() async {
    await getlocationData();

    WeatherData weatherData = WeatherData(locationdata: locationData);
    await weatherData.getCurrentTemperature();

    if(weatherData.currentTemperature == null || weatherData.currentCondition == null){
      print("Apiden sıcaklık bilgisi boş dönüyor");

    }
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder:
            (context){
          return MainScreen(weatherData);
        }
        )
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeather();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple,Colors.blue]
          )
        ),
        child: Center(
          child: SpinKitFadingCircle(
            color: Colors.white,
            size: 80.0,
            duration: Duration(milliseconds: 1200),
          ),
        ),
      ),
    );
  }
}
