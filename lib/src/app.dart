import 'package:flutter/material.dart';
import 'package:justcook/src/views/screens/details.dart';
import 'package:justcook/src/views/screens/home.dart';
import 'package:justcook/src/views/screens/ui.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Just Cook',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Avenir'),
      home: HomeScreen(),
    );
  }
}
