class Validate{
  bool isnumerical(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
}