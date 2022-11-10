part of 'check_out_bloc.dart';

abstract class CheckOutState extends Equatable {
  const CheckOutState();
}

class CheckOutInitial extends CheckOutState {
  @override
  List<Object> get props => [];
}

class CheckOutLoading extends  CheckOutState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class CheckOutSucsess<T> extends  CheckOutState{
  T data;
  CheckOutSucsess(this.data);
  @override
  // TODO: implement props
  List<Object?> get props => [data];
}
class CheckOutError extends  CheckOutState{
  String e;
  CheckOutError(this.e);
  @override
  // TODO: implement props
  List<Object?> get props => [e];
}