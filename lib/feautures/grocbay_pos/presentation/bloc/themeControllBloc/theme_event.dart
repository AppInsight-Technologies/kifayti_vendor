
part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class SetTheme extends ThemeEvent {
  final ThemeName themeName;
  const SetTheme(this.themeName);
  @override
  List<Object> get props => [themeName];
}
enum ThemeName{
  vendor,pos
}