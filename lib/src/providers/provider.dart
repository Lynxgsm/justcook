import 'package:flutter/material.dart';
import 'package:justcook/src/models/dish.model.dart';
import 'package:justcook/src/services/marmiton.service.dart';

class AppProvider with ChangeNotifier {
  String _searchText = '';
  DishModel _dishModel;
  MarmitonService _marmitonService = new MarmitonService();

  void searchMeal() {
    _marmitonService.searchDishes(_searchText).then((onValue) {
      _dishModel = onValue;
      notifyListeners();
    }).catchError((onError) {
      throw onError;
    });
  }

  String get searchText => _searchText;
  DishModel get dishModel => _dishModel;
}
