import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:justcook/src/constants/customColor.dart';
import 'package:justcook/src/constants/utils.dart';
import 'package:justcook/src/models/dish.dart';
import 'package:justcook/src/views/screens/details.dart';
import 'package:justcook/src/views/widgets/Badge.dart';

class DishCard extends StatelessWidget {
  final Dish dish;
  DishCard(this.dish);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 255,
      width: 180,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: CustomColor.yellowColor,
        elevation: 0,
        margin: EdgeInsets.only(top: 10, right: 10),
        child: Container(
          padding: EdgeInsets.only(bottom: 20),
          child: Flex(
            direction: Axis.vertical,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            DetailScreen(dish: dish)));
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.3), BlendMode.srcATop),
                          image: NetworkImage(
                            "${dish.image}",
                          ),
                        )),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(
                            Icons.favorite_border,
                            color: CustomColor.pinkColor,
                          ),
                        )),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: 200,
                  padding: EdgeInsets.only(left: 10, top: 5, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "${Utils.capitalize(dish.name)}",
                        softWrap: true,
                        style: TextStyle(fontFamily: 'Avenir Heavy'),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: 3.5, right: 4),
                              child: Icon(
                                FontAwesomeIcons.clock,
                                size: 12,
                              ),
                            ),
                            Text(
                              "${dish.duration}",
                            ),
                          ],
                        ),
                      ),
                      Badge("${dish.rate}")
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
