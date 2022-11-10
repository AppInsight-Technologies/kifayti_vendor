part of 'order_details.dart';

abstract class OrderDetailsState extends Equatable {
  const OrderDetailsState();
}


class OrderDetailsStateInitial extends OrderDetailsState {
  @override
  List<Object> get props => [];
}

class OrderDetailsStateLoading extends OrderDetailsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OrderDetailsStateSucsess<T> extends OrderDetailsState {
  T data;

  OrderDetailsStateSucsess(this.data);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OrderDetailsStateError extends OrderDetailsState {
  String e;

  OrderDetailsStateError(this.e);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

