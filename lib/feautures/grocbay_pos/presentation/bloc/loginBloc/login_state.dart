part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}


class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}
class LoginLoading extends  LoginState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class LoginSucsess<T> extends  LoginState{
  T data;
  LoginSucsess(this.data);
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class LoginError extends  LoginState{
  String e;
  LoginError(this.e);
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

