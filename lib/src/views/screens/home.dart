import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:justcook/src/constants/customColor.dart';
import 'package:justcook/src/models/dish.model.dart';
import 'package:justcook/src/providers/provider.dart';
import 'package:justcook/src/services/marmiton.service.dart';
import 'package:justcook/src/views/screens/classifier.dart';
import 'package:justcook/src/views/screens/favorite.dart';
import 'package:justcook/src/views/screens/profile.dart';
import 'package:justcook/src/views/widgets/Home/HeaderSearch.dart';
import 'package:justcook/src/views/widgets/Home/Search.dart';
import 'package:justcook/src/views/widgets/Home/Trending.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  MarmitonService _marmitonService = MarmitonService();
  DishModel _items;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<String> meals = [
    "banane, mangue",
    "oeuf, farine",
    "boeuf, oignon, carotte",
    "poulet, oeuf, gratin"
  ];

  void getRandomMeals() {
    var rand = math.Random();
    var meal = rand.nextInt(meals.length);
    _marmitonService.searchDishes(meals[meal]).then((onValue) {
      setState(() {
        _items = onValue;
      });
    }).catchError((onError) {
      throw onError;
    });
  }

  @override
  void initState() {
    super.initState();
    getRandomMeals();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ChangeNotifierProvider(
        builder: (context) => AppProvider(),
        child: Scaffold(
            body: IndexedStack(
              index: _selectedIndex,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(top: 20, left: 20),
                    child: SingleChildScrollView(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Rechercher",
                            style: TextStyle(
                                fontFamily: 'Avenir Heavy', fontSize: 32)),
                        Text("des recettes",
                            style: TextStyle(
                                fontSize: 28, fontFamily: 'Avenir Medium')),
                        HeaderSearch(),
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
                        Padding(
                          padding: EdgeInsets.all(20),
                        ),
                        Text(
                          "Recettes par catégories",
                          style: TextStyle(
                              fontFamily: 'Avenir Heavy', fontSize: 24),
                        ),
                      ],
                    ))),
                FavoriteScreen(),
                ProfileScreen(),
                ClassifierScreen()
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: CustomColor.greenColor,
              selectedIconTheme: IconThemeData(color: Colors.white),
              selectedLabelStyle: TextStyle(color: Colors.white),
              unselectedItemColor: Colors.white.withOpacity(0.4),
              type: BottomNavigationBarType.fixed,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.book),
                  title: Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      'Recettes',
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'Avenir Medium'),
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.solidHeart),
                  title: Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      'Favoris',
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'Avenir Medium'),
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesomeIcons.user,
                    size: 20,
                  ),
                  title: Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      'Profile',
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'Avenir Medium'),
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesomeIcons.camera,
                    size: 20,
                  ),
                  title: Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      'Classifier',
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'Avenir Medium'),
                    ),
                  ),
                )
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.blue,
              onTap: _onItemTapped,
            )),
      ),
    );
  }
}
