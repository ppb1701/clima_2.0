import 'package:clima_2_0/utilities/constants.dart';
import 'package:flutter/cupertino.dart';

class WeatherDataText extends StatelessWidget {
  const WeatherDataText({@required this.text, this.data=false});

  final String text;
  final bool data;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$text',
      textAlign: TextAlign.right,
      style: data ? kDataTextStyle : kMessageTextStyle,
    );
  }
}
