import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:location/location.dart';
import 'package:weather_app/Utils/location.dart';
import 'package:http/http.dart';



const apikey = "01c3e0d757e7d1898321577371a01a7c";


class WeatherDisplayData{
  Icon weatherIcon;
  AssetImage weatherImage;
  WeatherDisplayData(@required this.weatherIcon,@required this.weatherImage);


}



class WeatherData{
  WeatherData({@required this.locationdata});
  LocationHelper? locationdata;

  double? currentTemperature;
  int? currentCondition;

  Future<void> getCurrentTemperature() async {
    String url = "https://api.openweathermap.org/data/2.5/weather?lat=${locationdata?.latitude}&lon=${locationdata?.longitude}&appid=${apikey}&unit=metric";
    Response response = await get(Uri.parse(url));

    if(response.statusCode == 200){
      String data = response.body;

      var currentWeather = jsonDecode(data);

      try{
        currentTemperature = currentWeather['main']['temp'];
        currentCondition = currentWeather['weather'][0]['id'];
      }
      catch(e){
        print(e);
      };


    }else  {
      print("Apiden değer gelmiyor");
    }


  }
  WeatherDisplayData? getWeatherDataDisplay(){
    if(currentCondition! < 600){
      return WeatherDisplayData(
          Icon(
            FontAwesomeIcons.cloud,
            size: 75.0,
          ),
          AssetImage('assets/headline.jpg')
      );
    }
    else{
      var now = new DateTime.now();
      if(now.hour >= 19){
        return WeatherDisplayData(
            Icon(
              FontAwesomeIcons.moon,
              size: 75.0,
            ),
            AssetImage('assets/download.jpg')
        );
      }
      else{
        return WeatherDisplayData(
            Icon(
              FontAwesomeIcons.sun,
              size: 75.0,
            ),
            AssetImage('assets/güneşli.jpg')
        );
      }

    }
  }
}