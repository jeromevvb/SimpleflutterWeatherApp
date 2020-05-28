import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  var temperature;

  Header(this.temperature);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        color: Colors.blue[600],
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                'Currently in Ko Samui',
                style: TextStyle(color: Colors.white, fontSize: 14.00),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(
                temperature.toString() + '\u00B0',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.00,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
