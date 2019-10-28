import 'package:justcook/src/models/dish.dart';

class DishModel {
  List<Dish> _items;

  DishModel.fromJson(List<dynamic> parsedJson) {
    List<Dish> itms = [];
    for (int i = 0; i < parsedJson.length; i++) {
      Dish it = Dish(parsedJson[i]);
      itms.add(it);
    }

    _items = itms;
  }

  List<Dish> get dishes => _items;
}
