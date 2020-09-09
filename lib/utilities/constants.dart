import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 66.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 40.0,
);

const kDataTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 25.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
);

const kConditionTextStyle = TextStyle(
  fontSize: 66.0,
);

const kInputTextStyle = InputDecoration(
    filled: true,
    fillColor: Colors.white,
    icon: Icon(
      Icons.location_city,
      color: Colors.white,
    ),
    hintText: 'ENTER CITY NAME OR ZIP CODE',
    hintStyle: TextStyle(
      color: Colors.grey,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
      borderSide: BorderSide.none,
    ));

const kBackgroundContainerBoxDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [Colors.blueAccent, Colors.white38],
    stops: [0.0, 9.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
);