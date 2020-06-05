import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  var temperature;

  Header(this.temperature);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3 - 25,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/lighthouse.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.search),
            ),
          )
        ],
      ),
    ));
  }
}
