import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../injection_container.dart';
part 'theme_event.dart';
part 'theme_state.dart';
class ThemeBloc extends  Bloc<ThemeEvent, ThemeState>{

  ThemeBloc() : super(ThemeStateInitial(ThemesData(_Themes.themes.first,sl<SharedPreferences>().getString("userType") == "Admin"?ThemeName.vendor:ThemeName.pos))){
    on<ThemeEvent>((event, emit) async{
      ThemeData? _theme;
      // emit(ThemeStateInitial(ThemesData(_Themes.themes.first,ThemeName.pos)));
      // TODO: implement event handler
      if(event is SetTheme) {
        emit(ThemeStateLoading());
        switch(event.themeName){
          case ThemeName.vendor:
          // TODO: Handle this case.
            _theme = _Themes.themes[0];
            break;
          case ThemeName.pos:
          // TODO: Handle this case.
            _theme = _Themes.themes[1];
            break;
        }
        emit(ThemeStateSucsess<ThemesData>( ThemesData(_theme,event.themeName)));
      }
    });
  }
}

class ThemesData{
  final ThemeData theme;
  final ThemeName name;
  const ThemesData(this.theme, this.name);
}
class _Themes{
  static List<ThemeData> themes= [
    ThemeData(
      // appBarTheme: const AppBarTheme(color: Color(0XFF37BD6A)),
      appBarTheme: const AppBarTheme(color: Colors.white),
      bottomNavigationBarTheme:  const BottomNavigationBarThemeData(
          backgroundColor: Color(0XFF142134),
          // backgroundColor: Color(0XFF142134),
          selectedLabelStyle: TextStyle(color: Colors.white),
          // selectedIconTheme: ThemeData(buttonColor: Color(value)),
          selectedItemColor: Colors.transparent,
          unselectedItemColor: Colors.transparent),
      fontFamily: /*sl<SharedPreferences>().getString("Languageid") == "tr"?*//*"RobotoSerif"*/'RobotoSerif',
      //primarySwatch: Colors.green,
      primarySwatch: MaterialColor(0xff7C4B9B, {
        50: Color(0xff7C4B9B),
        100: Color(0xff7C4B9B),
        200: Color(0xff7C4B9B),
        300: Color(0xff7C4B9B),
        400: Color(0xff7C4B9B),
        500: Color(0xff7C4B9B),
        600: Color(0xff7C4B9B),
        700: Color(0xff7C4B9B),
        800: Color(0xff7C4B9B),
        900: Color(0xff7C4B9B),
      }),
    ),
    ThemeData(
      appBarTheme: const AppBarTheme(color: Colors.white),
      bottomNavigationBarTheme:  const BottomNavigationBarThemeData(
         // backgroundColor: Color(0XFF142134),
  backgroundColor: Colors.grey,
          selectedLabelStyle: TextStyle(color: Colors.white),
          // selectedIconTheme: ThemeData(buttonColor: Color(value)),
          selectedItemColor: Colors.transparent,
          unselectedItemColor: Colors.transparent),
      fontFamily: /*sl<SharedPreferences>().getString("Languageid") == "tr"?"RobotoSerif":*/'RobotoSerif',
      //primarySwatch: Colors.green,
      //primarySwatch: Colors.green,
      primarySwatch: MaterialColor(0xff7C4B9B, {
        50: Color(0xff7C4B9B),
        100: Color(0xff7C4B9B),
        200: Color(0xff7C4B9B),
        300: Color(0xff7C4B9B),
        400: Color(0xff7C4B9B),
        500: Color(0xff7C4B9B),
        600: Color(0xff7C4B9B),
        700: Color(0xff7C4B9B),
        800: Color(0xff7C4B9B),
        900: Color(0xff7C4B9B),
      }),
    )
  ];
}