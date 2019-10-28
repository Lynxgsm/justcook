import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:justcook/src/constants/customColor.dart';

class Badge extends StatelessWidget {
  final String rate;
  Badge(this.rate);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(top: 10),
      width: 50,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.star, color: CustomColor.yellowLightColor, size: 14),
          Padding(
            padding: EdgeInsets.all(2),
          ),
          Container(
            margin: EdgeInsets.only(top: 2),
            child: Text(
              "$rate",
              style: TextStyle(fontFamily: 'Avenir Medium'),
            ),
          )
        ],
      ),
    );
  }
}
