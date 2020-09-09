import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {

NetworkHelper(this.url);

final String url;


Future getData() async {
  // print('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey');
  http.Response response = await http.get(
      url);
  String data;
  if (response.statusCode == 200) {
    data = response.body;
    return jsonDecode(data);
  } else {
    print(response.statusCode);
  }
}

}