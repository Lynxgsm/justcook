import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:justcook/src/constants/customColor.dart';
import 'dart:math' as math;
import 'package:justcook/src/models/DetailDish.dart';
import 'package:justcook/src/models/dish.dart';
import 'package:justcook/src/services/marmiton.service.dart';
import 'package:toast/toast.dart';

class DetailScreen extends StatefulWidget {
  final Dish dish;
  DetailScreen({this.dish});
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  MarmitonService _marmitonService = MarmitonService();
  DishDetails details;
  void getDetails() {
    _marmitonService.dishDetail("${widget.dish.url}").then((onValue) {
      print(onValue);
      setState(() {
        details = onValue;
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            widget.dish.name,
            style: TextStyle(fontFamily: 'Avenir Heavy', color: Colors.black),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.favorite_border,
                color: Colors.black,
              ),
              onPressed: () {},
            )
          ],
        ),
        body: Container(child: sliver(details, widget.dish)));
  }
}

Container _title(String text) {
  return Container(
    padding: EdgeInsets.only(top: 20, left: 20),
    child: Text(
      text,
      style: TextStyle(fontFamily: 'Avenir Heavy', fontSize: 16),
    ),
  );
}

class Ingredients extends StatelessWidget {
  final List<String> ingredients;
  Ingredients(this.ingredients);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 20, right: 20),
      width: double.infinity,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: ingredients.map((ingredient) {
            return Text("- $ingredient");
          }).toList()),
    );
  }
}

class Steps extends StatelessWidget {
  final List<String> steps;
  Steps(this.steps);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 20, right: 20),
      width: double.infinity,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: steps.map((step) {
            return Container(
                margin: EdgeInsets.only(bottom: 5), child: Text("- $step"));
          }).toList()),
    );
  }
}

class InfoPart extends StatelessWidget {
  final DishDetails detail;
  InfoPart(this.detail);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            textWithIcon(detail.budget, Icons.monetization_on, 'Coût', context),
            textWithIcon(detail.cooktime, FontAwesomeIcons.burn,
                'Temps de cuisson', context),
            textWithIcon(detail.preparationTime, Icons.timer,
                'Temps de préparation', context),
            textWithIcon(detail.difficulty, FontAwesomeIcons.layerGroup,
                'Difficulté', context),
            textWithIcon(detail.peopleQte, FontAwesomeIcons.user,
                'Nombre de personnes', context),
          ],
        ),
      ),
    );
  }
}

Widget textWithIcon(
    String text, IconData icon, String setting, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Toast.show(setting, context, duration: 3);
    },
    child: Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: 5),
      padding: EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(icon, color: CustomColor.yellowLightColor, size: 14),
          Padding(
            padding: EdgeInsets.all(2),
          ),
          Container(
            margin: EdgeInsets.only(top: 2),
            child: Text(
              "$text",
              style:
                  TextStyle(fontFamily: 'Avenir Medium', color: Colors.white),
            ),
          )
        ],
      ),
    ),
  );
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

Widget sliver(DishDetails details, Dish dish) {
  return (CustomScrollView(
    slivers: <Widget>[
      SliverPersistentHeader(
        pinned: false,
        delegate: _SliverAppBarDelegate(
            minHeight: 130.0,
            maxHeight: 250.0,
            child: Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(dish.image))),
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      dish.name,
                      style: TextStyle(
                          fontFamily: 'Avenir Heavy',
                          fontSize: 30,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            )),
      ),
      SliverList(
        delegate: SliverChildListDelegate([
          details == null
              ? Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.all(50),
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          CustomColor.greenColor),
                    ),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    InfoPart(details),
                    _title("Ingrédients"),
                    Ingredients(details.ingredients),
                    _title("Etapes"),
                    Steps(details.steps)
                  ],
                ),
        ]),
      )
    ],
  ));
}
