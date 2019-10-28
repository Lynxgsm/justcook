import 'package:flutter/material.dart';
import 'package:justcook/src/constants/customColor.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Vos plats favoris",
          style: TextStyle(fontFamily: 'Avenir Heavy'),
        ),
        backgroundColor: CustomColor.yellowLightColor,
      ),
    );
  }
}
