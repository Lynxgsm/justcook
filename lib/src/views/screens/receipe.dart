import 'package:flutter/material.dart';
import 'package:justcook/src/constants/customColor.dart';
import 'package:justcook/src/models/dish.model.dart';
import 'package:justcook/src/services/marmiton.service.dart';
import 'package:justcook/src/views/widgets/Home/HeaderSearch.dart';
import 'package:justcook/src/views/widgets/Home/Trending.dart';

class ReceipeScreen extends StatefulWidget {
  final String query;
  ReceipeScreen(this.query);
  @override
  _ReceipeScreenState createState() => _ReceipeScreenState();
}

class _ReceipeScreenState extends State<ReceipeScreen> {
  MarmitonService _marmitonService = MarmitonService();
  DishModel _items;

  void getQueryMeals() {
    _marmitonService.searchDishes(widget.query).then((onValue) {
      setState(() {
        _items = onValue;
      });
    }).catchError((onError) {
      throw onError;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getQueryMeals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              'Recettes',
              style: TextStyle(fontFamily: 'Avenir Heavy', color: Colors.black),
            )),
        body: Container(
            padding: EdgeInsets.only(top: 20, left: 20),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Recettes",
                    style: TextStyle(fontFamily: 'Avenir Heavy', fontSize: 32)),
                Text("avec ${widget.query}",
                    style:
                        TextStyle(fontSize: 28, fontFamily: 'Avenir Medium')),
                // HeaderSearch(),
                _items == null
                    ? Container(
                        padding: EdgeInsets.all(100),
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              CustomColor.greenColor),
                        ),
                      )
                    : Trending(_items),
              ],
            ))));
  }
}
