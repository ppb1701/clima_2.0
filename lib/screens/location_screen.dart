import 'dart:io';

import 'package:clima_2_0/components/weather_data_text.dart';
import 'package:clima_2_0/utilities/weather_data.dart';
import 'package:flutter/material.dart';
import 'package:clima_2_0/utilities/constants.dart';
import 'package:clima_2_0/screens/city_screen.dart';
import 'package:clima_2_0/services/weather.dart';
import 'package:recase/recase.dart';

bool isLoaded = false;

class LocationScreen extends StatefulWidget {
  final locationWeather;
  LocationScreen({this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  WeatherData weatherCurrent = WeatherData();
  dynamic location;
  @override
  void initState() {
    super.initState();
    // print(widget.locationWeather);
    setState(() {
      updateUI(widget.locationWeather);
    });
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        weatherCurrent.temperature = 0;
        weatherCurrent.weatherIcon = 'Error';
        weatherCurrent.weatherMessage =
            'There was an error getting location data.';
        return;
      }
      // print(weatherData);
      weatherCurrent.temperature = weatherData['main']['temp'];
      weatherCurrent.weatherFeelsLike = weatherData['main']['feels_like'];
      weatherCurrent.weatherMinTemp = weatherData['main']['temp_min'];
      weatherCurrent.weatherMaxTemp = weatherData['main']['temp_max'];
      weatherCurrent.weatherHumidity = weatherData['main']['humidity'];
      weatherCurrent.weatherPressure = weatherData['main']['pressure'];
      weatherCurrent.weatherFeelsLike = weatherData['main']['feels_like'];
      weatherCurrent.weatherSpeed = weatherData['wind']['speed'];
      weatherCurrent.weatherDirection = weatherData['wind']['deg'];
      weatherCurrent.weatherDirectionText =
          weather.degToCompass(weatherCurrent.weatherDirection);
      var condition = weatherData['weather'][0]['id'];
      weatherCurrent.weatherIcon = weather.getWeatherIcon(condition);
      weatherCurrent.weatherMessage = weatherData['weather'][0]['description'];
      weatherCurrent.weatherMessage =
          weatherCurrent.weatherMessage.sentenceCase;
      weatherCurrent.cityName = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: kBackgroundContainerBoxDecoration,
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () async {
                          var weatherData = await weather.getLocationWeather();
                          updateUI(weatherData);
                        },
                        child: Icon(
                          Icons.near_me,
                          size: 50.0,
                        ),
                      ),
                      FlatButton(
                        onPressed: () async {
                          var typedName =
                              await Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return CityScreen();
                            },
                          ));
                          if (typedName != null) {
                            var weatherData =
                                await (num.tryParse(typedName) != null
                                    ? weather.getZipcodeWeather(typedName)
                                    : weather.getCityWeather(typedName));
                            updateUI(weatherData);
                          }
                        },
                        child: Icon(
                          Icons.location_city,
                          size: 50.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '${weatherCurrent.temperature}°',
                    style: kTempTextStyle,
                  ),
                  Text(
                    weatherCurrent.weatherIcon,
                    style: kConditionTextStyle,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WeatherDataText(
                    text: '${weatherCurrent.cityName}',
                  ),
                  WeatherDataText(text: weatherCurrent.weatherMessage),
                  WeatherDataText(
                    text: 'Feels like: ${weatherCurrent.weatherFeelsLike}°',
                    data: true,
                  ),
                  WeatherDataText(
                    text: 'High Today: ${weatherCurrent.weatherMaxTemp}°',
                    data: true,
                  ),
                  WeatherDataText(
                    text: 'Low Today: ${weatherCurrent.weatherMinTemp}°',
                    data: true,
                  ),
                  WeatherDataText(
                    text: 'Humidity: ${weatherCurrent.weatherHumidity}%',
                    data: true,
                  ),
                  WeatherDataText(
                    text: 'Wind Speed: ${weatherCurrent.weatherSpeed} mph',
                    data: true,
                  ),
                  WeatherDataText(
                    text:
                        'Wind Direction: ${weatherCurrent.weatherDirectionText}',
                    data: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
