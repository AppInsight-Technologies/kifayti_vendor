part of 'theme_bloc.dart';



abstract class ThemeState extends Equatable {
  const ThemeState();
}


class ThemeStateInitial extends ThemeState {
  ThemesData? data;
  ThemeStateInitial(this.data);

  @override
  List<Object?> get props => [data];
}

class ThemeStateLoading extends ThemeState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ThemeStateSucsess<T> extends ThemeState {
  T data;

  ThemeStateSucsess(this.data);

  @override
  // TODO: implement props
  List<Object?> get props => [data];
}

class ThemeStateError extends ThemeState {
  String e;

  ThemeStateError(this.e);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}