import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'widgets/header.dart';
import 'widgets/listview.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:moment/moment.dart';

class Home extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Home> {
  var temperature;
  var weather;

  Future getWeather() async {
    const url =
        'http://api.openweathermap.org/data/2.5/weather?q=Ko Samui&appid=5fc47362925abcb0b8417e49c8cc59e0&units=metric';

    // Await the http get response, then decode the json-formatted response.
    try {
      var request = await http.get(url);
      var response = convert.jsonDecode(request.body);
      print(request.body);
      setState(() {
        this.temperature = response["main"]["temp"];
        this.weather = response["weather"][0];

        print(this.weather);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
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
                  'Ko Samui',
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(width: 5),
                Icon(Icons.place),
              ]),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                weather != null ? weather["description"] : "",
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
