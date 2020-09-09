import 'package:clima_2_0/components/weather_data_text.dart';
import 'package:flutter/material.dart';
import 'package:clima_2_0/utilities/constants.dart';
import 'package:clima_2_0/screens/city_screen.dart';
import 'package:clima_2_0/services/weather.dart';
import 'package:recase/recase.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;
  LocationScreen({this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  dynamic temperature;
  dynamic weatherIcon;
  dynamic cityName;
  String weatherMessage;
  dynamic weatherFeelsLike;
  dynamic weatherMinTemp;
  dynamic weatherMaxTemp;
  dynamic weatherHumidity;
  dynamic weatherPressure;
  dynamic weatherSpeed;
  dynamic weatherDirection;
  String weatherDirectionText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(widget.locationWeather);
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'There was an error getting location data.';
        return;
      }
      // print(weatherData);
      print(weatherData);
      dynamic temp = weatherData['main']['temp'];
      dynamic feelsLike = weatherData['main']['feels_like'];
      dynamic minTemp = weatherData['main']['temp_min'];
      dynamic maxTemp = weatherData['main']['temp_max'];
      dynamic humidity = weatherData['main']['humidity'];
      dynamic pressure = weatherData['main']['pressure'];
      dynamic windSpeed = weatherData['wind']['speed'];
      dynamic windDegree = weatherData['wind']['deg'];
      temperature = temp;
      weatherMinTemp = minTemp;
      weatherMaxTemp = maxTemp;
      weatherHumidity = humidity;
      weatherPressure = pressure;
      weatherFeelsLike = feelsLike;
      weatherSpeed = windSpeed;
      weatherDirection = windDegree;
      weatherDirectionText = weather.degToCompass(windDegree);
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weatherData['weather'][0]['description'];
      weatherMessage = weatherMessage.sentenceCase;
      cityName = weatherData['name'];
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
              Padding(
                padding: EdgeInsets.only(left: 15.0, top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WeatherDataText(
                      text: '$cityName',
                    ),
                    WeatherDataText(text: weatherMessage),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0),
                    ),
                    WeatherDataText(
                      text: 'Feels like: $weatherFeelsLike',
                      data: true,
                    ),
                    WeatherDataText(
                      text: 'High Today: $weatherMaxTemp',
                      data: true,
                    ),
                    WeatherDataText(
                      text: 'Low Today: $weatherMinTemp',
                      data: true,
                    ),
                    WeatherDataText(
                      text: 'Humidity: $weatherHumidity%',
                      data: true,
                    ),
                    WeatherDataText(
                      text: 'Wind Speed: $weatherSpeed mph',
                      data: true,
                    ),
                    WeatherDataText(
                      text: 'Wind Direction: $weatherDirectionText',
                      data: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
