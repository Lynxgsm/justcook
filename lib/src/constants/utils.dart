class Utils {
  Utils._();

  static String capitalize(String text) {
    var s = text.split('');
    s[0] = s[0].toUpperCase();
    return s.join();
  }
}
