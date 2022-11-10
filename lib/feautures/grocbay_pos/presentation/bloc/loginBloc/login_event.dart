part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}
class OnCLickLogin extends LoginEvent{
  String email;
  String password;
  OnCLickLogin(this.email,this.password);
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class FetchUserData extends LoginEvent{

  FetchUserData();
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class OnCLickLogout extends LoginEvent{

  OnCLickLogout();
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
