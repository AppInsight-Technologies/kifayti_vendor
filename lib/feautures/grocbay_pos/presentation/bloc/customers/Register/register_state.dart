part of 'register_bloc.dart';



abstract class RegisterState extends Equatable {
  const RegisterState();
}


class RegisterInitial extends RegisterState {
  @override
  List<Object> get props => [];
}
class RegisterLoading extends  RegisterState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class RegisterSucsess<T> extends  RegisterState{
  T data;
  RegisterSucsess(this.data);
  @override
  // TODO: implement props
  List<Object?> get props => [data];
}
class RegisterError extends  RegisterState{
  String e;
  RegisterError(this.e);
  @override
  // TODO: implement props
  List<Object?> get props => [e];
}