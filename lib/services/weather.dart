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

  String degToCompass(num) {
    // dynamic val = ((num / 22.5) + 0.5);
    List<String> arr = [
      "N",
      "NE",
      "E",
      "SE",
      "S",
      "SW",
      "W",
      "NW",
    ];
    // print(val);
    return arr[((num %8)+0.5).round()];
  }

  Future getCityWeather(String cityName) async {
    var url = '$openWeatherMapURL?q=$cityName&units=imperial&appid=$apiKey';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = networkHelper.getData();
    print(weatherData);
    return weatherData;
  }

  Future getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?units=imperial&lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future getZipcodeWeather(String zipCode, {String countryCode = 'us'}) async {
    var url =
        '$openWeatherMapURL?units=imperial&zip=$zipCode,$countryCode&appid=$apiKey';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }
}
