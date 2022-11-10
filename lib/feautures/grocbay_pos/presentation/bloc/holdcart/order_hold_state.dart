part of 'order_hold.dart';

abstract class OrderHoldState extends Equatable {
  const OrderHoldState();
}


class OrderHoldStateInitial extends OrderHoldState {
  @override
  List<Object> get props => [];
}

class OrderHoldStateLoading extends OrderHoldState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OrderHoldStateSucsess<T> extends OrderHoldState {
  T data;

  OrderHoldStateSucsess(this.data);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OrderHoldStateError extends OrderHoldState {
  String e;

  OrderHoldStateError(this.e);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

