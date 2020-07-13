import 'package:flutter/material.dart';
import 'package:flutter_weather_app/home/widgets/body.dart';

import 'package:geolocator/geolocator.dart';

class Home extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Home> {
  Position currentPosition;
  bool loaded = false;

  Future getPosition() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      setState(() {
        currentPosition = position;
        loaded = true;
      });

      print('works here');
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
      body: !loaded
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Body(currentPosition: currentPosition),
    );
  }
}
