class DishDetails {
  String _budget;
  String _cooktime;
  String _difficulty;
  List<String> _ingredients;
  List<String> _steps;
  String _duration;
  String _preparationTime;
  String _peopleQte;

  DishDetails.fromJson(Map dish) {
    List<String> ings = [];
    List<String> insteps = [];
    _budget = dish['budget'];
    _cooktime = dish['cook_time'];
    _difficulty = dish['difficulty'];
    for (int i = 0; i < dish['ingredients'].length; i++) {
      String ing = dish['ingredients'][i];
      ings.add(ing);
    }

    _ingredients = ings;
    for (int i = 0; i < dish['steps'].length; i++) {
      String ing = dish['steps'][i];
      insteps.add(ing);
    }

    _steps = insteps;
    _preparationTime = dish['prep_time'];
    _duration = dish['duration'];
    _peopleQte = dish['people_quantity'];
  }

  String get budget => _budget;
  String get cooktime => _cooktime;
  String get difficulty => _difficulty;
  String get duration => _duration;
  String get peopleQte => _peopleQte;
  List<String> get ingredients => _ingredients;
  List<String> get steps => _steps;
  String get preparationTime => _preparationTime;
}
