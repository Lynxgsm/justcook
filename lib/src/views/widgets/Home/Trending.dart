import 'package:flutter/material.dart';
import 'package:justcook/src/models/dish.model.dart';
import 'package:justcook/src/views/widgets/DishCard.dart';

class Trending extends StatelessWidget {
  final DishModel items;
  Trending(this.items);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Vous pourriez aimez...",
            style: TextStyle(fontFamily: 'Avenir Heavy', fontSize: 24),
          ),
          Container(
            height: 10,
          ),
          TrendingContent(items)
        ],
      ),
    );
  }
}

class TrendingContent extends StatelessWidget {
  final DishModel items;
  TrendingContent(this.items);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            children: items.dishes.map((dish) {
          return DishCard(dish);
        }).toList()),
      ),
    );
  }
}
