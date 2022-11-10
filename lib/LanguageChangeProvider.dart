import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'injection_container.dart';

class LanguageChangeProvider with ChangeNotifier{
  Locale _currentLocale = Locale(/*(sl<SharedPreferences>().containsKey("userType") && sl<SharedPreferences>().getString("userType") == "Admin")?"tr":*/"en");

  Locale get currentLocale => _currentLocale;

  void changeLocale(String _locale){
    this._currentLocale = new Locale(_locale);
    notifyListeners();
  }

}