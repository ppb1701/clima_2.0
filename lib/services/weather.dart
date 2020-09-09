import 'package:clima_2_0/services/networking.dart';
import 'package:clima_2_0/services/location.dart';

const apiKey = 'be7aee518f273c4f06bf2eaaf0d9b9d9';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }

  Future getCityWeather(String cityName) async {
    var url = '$openWeatherMapURL?q=$cityName&units=imperial&appid=$apiKey';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = networkHelper.getData();
    return weatherData;
  }

  Future getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?units=imperial&lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey');
    var weatherData = await networkHelper.getData();
    // var weatherDescription = weatherData['weather'][0]['description'];
    // print(weatherDescription);
    return weatherData;
  }
}
