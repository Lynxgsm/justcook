import 'package:flutter/material.dart';
import 'package:justcook/src/models/dish.model.dart';
import 'package:justcook/src/views/widgets/DishCard.dart';

class Search extends StatelessWidget {
  final DishModel items;
  Search(this.items);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Résultat de votre recherche...",
            style: TextStyle(fontFamily: 'Avenir Heavy', fontSize: 24),
          ),
          Container(
            height: 10,
          ),
          SearchContent(items)
        ],
      ),
    );
  }
}

class SearchContent extends StatelessWidget {
  final DishModel items;
  SearchContent(this.items);
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
