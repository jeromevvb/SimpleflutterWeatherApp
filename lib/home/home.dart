import 'package:flutter/material.dart';
import 'widgets/header.dart';
import 'widgets/listview.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Home> {
  var temperature;

  Future getWeather() async {
    const url =
        'http://apixxx.openweathermap.org/data/2.5/weather?q=Ko Samui&appid=5fc47362925abcb0b8417e49c8cc59e0&units=metric';

    // Await the http get response, then decode the json-formatted response.
    try {
      var request = await http.get(url);
      var response = convert.jsonDecode(request.body);
      print(request.body);
      setState(() {
        this.temperature = response["main"]["temp"];
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
      body: Column(children: [Header(temperature), ListViewData(temperature)]),
    );
  }
}
