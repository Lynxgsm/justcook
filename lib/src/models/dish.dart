class Dish {
  String _name;
  String _description;
  String _url;
  String _image;
  String _rate;
  String _duration;

  Dish(Map dish) {
    _name = dish['name'];
    _description = dish['description'];
    _url = dish['url'];
    _image = dish['image'];
    _rate = dish['rate'];
    _duration = dish['duration'];
  }

  String get name => _name;
  String get description => _description;
  String get url => _url;
  String get image => _image;
  String get rate => _rate;
  String get duration => _duration;
}
