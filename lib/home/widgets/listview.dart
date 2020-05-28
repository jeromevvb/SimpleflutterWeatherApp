import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListViewData extends StatelessWidget {
  var temperature;

  ListViewData(this.temperature);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          child: ListView(
        children: <Widget>[
          ListTile(
            leading: FaIcon(FontAwesomeIcons.thermometerHalf),
            title: Text('Temperature'),
            trailing: Text(temperature.toString() + '\u00B0'),
          )
        ],
      )),
    );
  }
}
