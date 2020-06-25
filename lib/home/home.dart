import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'widgets/header.dart';
import 'widgets/listview.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:moment/moment.dart';
import 'package:geolocator/geolocator.dart';

class Home extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Home> {
  var temperature;
  var weather;
  Position _currentPosition;
  String _currentCity;

  Future getPosition() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      setState(() {
        _currentPosition = position;
      });

      this.getWeather();
      this.getCity();
    } catch (e) {
      print(e);
    }
  }

  Future getCity() async {
    try {
      List<Placemark> p = await Geolocator().placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentCity = "${place.locality}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  //   Future getAddressFromLatLng() async {
  //   try {
  //     List<Placemark> p = await Geolocator().placemarkFromCoordinates(
  //         _currentPosition.latitude, _currentPosition.longitude);

  //     Placemark place = p[0];

  //     setState(() {
  //       _currentAddress =
  //           "${place.locality}, ${place.postalCode}, ${place.country}";
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future getWeather() async {
    // get weather
    var url =
        "http://api.openweathermap.org/data/2.5/weather?lat=${_currentPosition.latitude}&lon=${_currentPosition.longitude}&appid=5fc47362925abcb0b8417e49c8cc59e0&units=metric";

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
    this.getPosition();
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
                  _currentCity.toString(),
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
