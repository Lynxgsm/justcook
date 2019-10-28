import 'package:flutter/material.dart';

class UIScreen extends StatefulWidget {
  @override
  _UIScreenState createState() => _UIScreenState();
}

class _UIScreenState extends State<UIScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        child: RaisedButton(
          color: Colors.teal,
          child: Text(
            "Hello World",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
