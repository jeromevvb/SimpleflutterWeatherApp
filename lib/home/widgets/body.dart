import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'header.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:moment/moment.dart';

class Body extends StatefulWidget {
  Position currentPosition;

  Body({this.currentPosition});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String currentCity;
  double temperature;
  String weatherDescription = "";

  Future getCity() async {
    try {
      List<Placemark> p = await Geolocator().placemarkFromCoordinates(
          widget.currentPosition.latitude, widget.currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        currentCity = "${place.locality}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  Future getWeather() async {
    // get weather
    String appId = DotEnv().env['OPEN_WEATHER_APP_ID'];
    var url =
        "http://api.openweathermap.org/data/2.5/weather?lat=${widget.currentPosition.latitude}&lon=${widget.currentPosition.longitude}&appid=${appId}&units=metric";

    // Await the http get response, then decode the json-formatted response.
    try {
      var request = await http.get(url);
      var response = convert.jsonDecode(request.body);
      print(response);
      setState(() {
        temperature = response["main"]["temp"];
        weatherDescription = response["weather"][0]["description"];
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
    this.getCity();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Header(temperature),
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Icon(Icons.access_time),
                SizedBox(width: 5),
                Text(
                  Moment().format('HH:mm'),
                  style: TextStyle(fontSize: 15),
                )
              ]),
              Row(children: [
                Text(
                  currentCity.toString(),
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(width: 5),
                Icon(Icons.place),
              ]),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                weatherDescription,
                style: TextStyle(fontSize: 14.00, color: Colors.grey[600]),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(
                temperature.toString() + '\u00B0',
                style: TextStyle(
                  fontSize: 50.00,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
