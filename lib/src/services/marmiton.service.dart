import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:justcook/src/constants/urls.dart';
import 'package:justcook/src/models/DetailDish.dart';
import 'package:justcook/src/models/dish.model.dart';

class MarmitonService {
  Client client = new Client();

  Future<DishModel> searchDishes(String ingredients) async {
    var response = await client.get("$urlBase/search/$ingredients");

    if (response.statusCode == 200) {
      return DishModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load dishes');
    }
  }

  Future<DishDetails> dishDetail(String url) async {
    var response = await client.post("$urlBase/getDetails", body: {"url": url});

    if (response.statusCode == 200) {
      return DishDetails.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load dishes');
    }
  }
}
